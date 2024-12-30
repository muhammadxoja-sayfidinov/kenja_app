import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login.dart';
import '../models/register.dart';

enum AuthStatus { unauthenticated, authenticating, authenticated, error }

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

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(status: AuthStatus.unauthenticated)) {
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');

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

  Future<void> login(String emailOrPhone, String password) async {
    final url = Uri.parse('https://owntrainer.uz/api/users/login/');
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
        // print('Access Token: ${loginResponse.access}');
        await saveTokens(loginResponse);

        state = state.copyWith(
          status: AuthStatus.authenticated,
          loginResponse: loginResponse,
        );
      } else {
        final errorData = jsonDecode(response.body);
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: errorData['detail'] ?? 'Kirish muvaffaqiyatsiz bo‘ldi',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Xatolik yuz berdi: $e',
      );
    }
  }

  Future<void> register(RegisterRequest request) async {
    final url = Uri.parse('https://owntrainer.uz/api/users/register/');
    try {
      state = state.copyWith(status: AuthStatus.authenticating);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 201) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          errorMessage: null,
        );
      } else {
        final errorData = jsonDecode(response.body);
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage:
              errorData['detail'] ?? 'Roʻyxatdan oʻtishda xatolik yuz berdi',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Serverga ulanishda xatolik: $e',
      );
    }
  }

  Future<void> saveTokens(LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', loginResponse.access);
    await prefs.setString('refresh_token', loginResponse.refresh);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    state = AuthState(status: AuthStatus.unauthenticated);
  }
}
