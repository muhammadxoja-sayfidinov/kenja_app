// lib/providers/auth_provider.dart

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kenja_app/data/providers/providers.dart';

import '../../config/constants.dart';
import '../models/auth/login.dart';
import '../models/auth/register_initial_model.dart';
import '../repositories/user_repository.dart';

// AuthStatus Enum
enum AuthStatus {
  unauthenticated,
  authenticating,
  authenticated,
  registering,
  verifying,
  error
}

// AuthState Class
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

// AuthNotifier Class
class AuthNotifier extends StateNotifier<AuthState> {
  final UserRepository _userRepository;
  final FlutterSecureStorage _secureStorage;

  AuthNotifier(this._userRepository, this._secureStorage)
      : super(AuthState(status: AuthStatus.unauthenticated)) {
    _checkAuthentication();
  }

  /// Login funksiyasi
  Future<void> login(String emailOrPhone, String password) async {
    try {
      state = state.copyWith(status: AuthStatus.authenticating);

      final loginResponse = await _userRepository.login(emailOrPhone, password);
      await saveTokens(loginResponse);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        loginResponse: loginResponse,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Kirish muvaffaqiyatsiz bo\'ldi: $e',
      );
    }
  }

  /// Register Initial funksiyasi
  Future<void> registerInitial(RegisterInitialModel model) async {
    try {
      state = state.copyWith(status: AuthStatus.registering);

      final userId = await _userRepository.registerInitial(model);
      await _secureStorage.write(key: 'user_id', value: userId.toString());

      state = state.copyWith(
        status: AuthStatus.unauthenticated, // Tasdiqlash talab etiladi
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Registratsiya muvaffaqiyatsiz bo\'ldi: $e',
      );
    }
  }

  /// Verify Code funksiyasi
  Future<void> verifyCode(String code) async {
    try {
      state = state.copyWith(status: AuthStatus.verifying);

      final userIdString = await _secureStorage.read(key: 'user_id');
      if (userIdString == null) {
        throw Exception('User ID not found. Avval registratsiya qiling.');
      }
      final userId = int.parse(userIdString);

      final verifyResponse = await _userRepository.verifyCode(userId, code);
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
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Tasdiqlash muvaffaqiyatsiz bo\'ldi: $e',
      );
    }
  }

  /// Tokenlarni saqlash funksiyasi
  Future<void> saveTokens(LoginResponse loginResponse) async {
    await _secureStorage.write(
        key: Constants.accessTokenKey, value: loginResponse.access);

    if (loginResponse.refresh != null) {
      await _secureStorage.write(
          key: Constants.refreshTokenKey, value: loginResponse.refresh);
    }
  }

  /// Logout qilish funksiyasi
  Future<void> logout() async {
    await _secureStorage.delete(key: Constants.accessTokenKey);
    await _secureStorage.delete(key: Constants.refreshTokenKey);
    await _secureStorage.delete(key: 'user_id');

    state = AuthState(status: AuthStatus.unauthenticated);
  }

  /// Avvaldan autentifikatsiya holatini tekshirish
  Future<void> _checkAuthentication() async {
    try {
      final accessToken =
          await _secureStorage.read(key: Constants.accessTokenKey);
      final refreshToken =
          await _secureStorage.read(key: Constants.refreshTokenKey);

      if (accessToken != null && refreshToken != null) {
        try {
          // Token validligini tekshirish uchun profil ma'lumotlarini olishga harakat qilish
          await _userRepository.getUserProfile();

          state = AuthState(
            status: AuthStatus.authenticated,
            loginResponse: LoginResponse(
              message: 'Already logged in',
              access: accessToken,
              refresh: refreshToken,
            ),
          );
        } catch (e) {
          print('Token tekshirishda xatolik: $e');
          // Token yangilash muvaffaqiyatsiz bo'lsa, logout qilish
          await logout();
        }
      } else {
        state = AuthState(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      print('Autentifikatsiya tekshirishda xatolik: $e');
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }

  /// Headerlarni olish funksiyasi
  Future<Map<String, String>> _getHeaders(
      Map<String, String>? additionalHeaders) async {
    final accessToken =
        await _secureStorage.read(key: Constants.accessTokenKey);

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

  /// HTTP POST So'rovini Yuborish (Optional)
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

  /// HTTP GET So'rovini Yuborish (Optional)
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _sendRequest(() async => http.get(
          Uri.parse("${Constants.baseUrl}$endpoint"),
          headers: await _getHeaders(headers),
        ));
  }

  /// So'rovlarni yuborish va tokenni yangilash
  Future<http.Response> _sendRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      print(
          'Original so‘rov status kodi: ${response.statusCode}'); // Log qo‘shildi

      if (response.statusCode == 401) {
        print(
            '401 javob olindi, tokenni yangilashga harakat qilinmoqda'); // Log qo‘shildi
        final refreshSuccess = await refreshToken();

        if (refreshSuccess) {
          print(
              'Token yangilandi, original so‘rov qayta yuborilmoqda'); // Log qo‘shildi
          return await request();
        } else {
          print('Token yangilanmadi, foydalanuvchi chiqishi'); // Log qo‘shildi
        }
      }

      return response;
    } catch (e) {
      print('So‘rov yuborishda xato: $e'); // Log qo‘shildi
      rethrow;
    }
  }

  /// Tokenni yangilash funksiyasi
  /// Tokenni yangilash funksiyasi
  Future<bool> refreshToken() async {
    try {
      final refreshToken =
          await _secureStorage.read(key: Constants.refreshTokenKey);
      print('Olingan refresh token: $refreshToken');

      if (refreshToken == null) {
        print('Refresh token topilmadi');
        await logout();
        return false;
      }

      final newTokens = await _userRepository.refreshToken(refreshToken);

      // Yangi tokenlarni saqlash
      await saveTokens(newTokens);

      // State'ni yangilash
      state = state.copyWith(
        status: AuthStatus.authenticated,
        loginResponse: newTokens,
      );

      print('Token muvaffaqiyatli yangilandi');
      return true;
    } catch (e) {
      print('Token yangilash xatosi: $e');
      await logout();
      return false;
    }
  }
}

// AuthProvider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final userRepository = UserRepository(
    baseUrl: Constants.baseUrl,
    secureStorage: secureStorage,
  );
  return AuthNotifier(userRepository, secureStorage);
});
