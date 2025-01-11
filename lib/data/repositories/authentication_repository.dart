// lib/providers/auth_provider.dart

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:kenja_app/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constants.dart';
import '../models/login.dart';
import '../models/register.dart';
import '../models/register_initial_model.dart';

// AuthStatus Enum
enum AuthStatus {
  unauthenticated,
  authenticating,
  authenticated,
  error,
  registering,
  verifying
}

// AuthState Klass
class AuthState {
  final AuthStatus status;
  final LoginResponse? loginResponse;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.loginResponse,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    LoginResponse? loginResponse,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      loginResponse: loginResponse ?? this.loginResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// AuthNotifier Klass
class AuthNotifier extends StateNotifier<AuthState> {
  final UserRepository _userRepository;

  AuthNotifier(this._userRepository)
      : super(AuthState(status: AuthStatus.unauthenticated)) {
    _checkAuthentication();
  }

  Future<void> registerInitial(RegisterInitialModel model) async {
    try {
      state = state.copyWith(status: AuthStatus.registering);
      final userId = await _userRepository.registerInitial(model);

      // Agar user_id saqlanishi kerak bo'lsa
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', userId);

      state = state.copyWith(
        status: AuthStatus.unauthenticated, // Tasdiqlash kerak
        loginResponse: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Registratsiya muvaffaqiyatsiz bo\'ldi: $e',
      );
    }
  }

  // Verify Code funksiyasi
  Future<void> verifyCode(String code) async {
    final url = Uri.parse('${Constants.baseUrl}/api/users/verify-code/');
    try {
      state = state.copyWith(status: AuthStatus.verifying);

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      if (userId == null) {
        throw Exception('User ID not found');
      }
      print('verifyCode ishladi');
      final body = {
        "user_id": userId.toString(),
        "code": code,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final verifyResponse = VerifyCodeResponse.fromJson(data);

        // Tokenlarni saqlash
        await saveTokens(LoginResponse(
          message: verifyResponse.message,
          access: verifyResponse.accessToken,
          refresh: verifyResponse.refreshToken,
        ));

        state = state.copyWith(
          status: AuthStatus.authenticated,
          loginResponse: LoginResponse(
            message: verifyResponse.message,
            access: verifyResponse.accessToken,
            refresh: verifyResponse.refreshToken,
          ),
        );
      } else {
        final errorData = jsonDecode(response.body);
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage:
              errorData['detail'] ?? 'Tasdiqlash muvaffaqiyatsiz bo\'ldi',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Xatolik yuz berdi: $e',
      );
    }
  }

  // Avvaldan autentifikatsiya holatini tekshirish
  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(Constants.accessTokenKey);
    final refreshToken = prefs.getString(Constants.refreshTokenKey);
    if (accessToken != null && refreshToken != null) {
      state = AuthState(
        status: AuthStatus.authenticated,
        loginResponse: LoginResponse(
          message: 'Already logged in',
          access: accessToken,
          refresh: refreshToken,
        ),
      );
    } else {
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }

  // Headerlarni olish
  Future<Map<String, String>> _getHeaders(
      Map<String, String>? additionalHeaders) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(Constants.accessTokenKey);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  // Login funksiyasi
  Future<void> login(String emailOrPhone, String password) async {
    final url = Uri.parse('${Constants.baseUrl}/api/users/login/');
    try {
      state = state.copyWith(status: AuthStatus.authenticating);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body:
            jsonEncode({'email_or_phone': emailOrPhone, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(data);
        await saveTokens(loginResponse);

        state = state.copyWith(
          status: AuthStatus.authenticated,
          loginResponse: loginResponse,
        );
      } else {
        final errorData = jsonDecode(response.body);
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: errorData['detail'] ?? 'Kirish muvaffaqiyatsiz bo\'ldi',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Xatolik yuz berdi: $e',
      );
    }
  }

  // HTTP POST So'rovini Yuborish (Optional)
  Future<http.Response> post(
    String endpoint,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    return _sendRequest(() async => http.post(
          Uri.parse("${Constants.baseUrl}$endpoint"),
          body: jsonEncode(body),
          headers: await _getHeaders(headers),
        ));
  }

  // HTTP GET So'rovini Yuborish (Optional)
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _sendRequest(() async => http.get(
          Uri.parse("${Constants.baseUrl}$endpoint"),
          headers: await _getHeaders(headers),
        ));
  }

  // So'rovlarni yuborish va tokenni yangilash
  Future<http.Response> _sendRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();

      if (response.statusCode == 401) {
        // Token muddati tugagan, yangilashga harakat qilish
        final refreshSuccess = await _refreshToken();

        if (refreshSuccess) {
          // Yangilangan token bilan original so'rovni qayta yuborish
          return await request();
        }
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString(Constants.refreshTokenKey);

      if (refreshToken == null) {
        return false;
      }

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/api/token/refresh/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'refresh': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Agar server yangi access token yuborsa
        if (data['access'] != null) {
          await prefs.setString(Constants.accessTokenKey, data['access']);
        }

        // Agar server yangi refresh token ham yuborsa, uni ham saqlash
        if (data['refresh'] != null) {
          await prefs.setString(Constants.refreshTokenKey, data['refresh']);
        }
        return true;
      }

      // Agar refresh ham o'tmasa, tokenlarni o'chirib tashlash
      await prefs.remove(Constants.accessTokenKey);
      await prefs.remove(Constants.refreshTokenKey);
      return false;
    } catch (e) {
      return false;
    }
  }

  // Tokenlarni saqlash
  Future<void> saveTokens(LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessTokenKey, loginResponse.access);
    await prefs.setString(Constants.refreshTokenKey, loginResponse.refresh);
  }

  // Logout qilish
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.accessTokenKey);
    await prefs.remove(Constants.refreshTokenKey);
    await prefs.remove('user_id');

    state = AuthState(status: AuthStatus.unauthenticated);
  }
}

// AuthProvider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final userRepository = UserRepository(baseUrl: Constants.baseUrl);
  return AuthNotifier(userRepository);
});
