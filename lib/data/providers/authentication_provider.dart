// auth_notifier.dart
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login.dart';

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
    // Ilova ishga tushganda tokenlarni tekshiramiz
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');
    final sessionId = prefs.getString('session_id');

    if (accessToken != null && refreshToken != null && sessionId != null) {
      // Tokenlar mavjud, `authState` ni yangilaymiz
      state = AuthState(
        status: AuthStatus.authenticated,
        loginResponse: LoginResponse(
          message: 'Already logged in',
          access: accessToken,
          refresh: refreshToken,
          sessionId: sessionId,
        ),
      );
    } else {
      // Tokenlar mavjud emas, `unauthenticated` holatda qolamiz
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login(String username, String password) async {
    print('Username: $username');
    print('Password: $password');
    state = state.copyWith(status: AuthStatus.authenticating);

    final url = Uri.parse('http://13.61.10.12:8000/api/v1/login/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(data);

        // Tokenlarni saqlash
        await saveTokens(loginResponse);

        state = state.copyWith(
          status: AuthStatus.authenticated,
          loginResponse: loginResponse,
        );
      } else {
        final errorData = jsonDecode(response.body);
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: errorData['error'] ?? 'Login muvaffaqiyatsiz bo\'ldi',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Xatolik yuz berdi: $e',
      );
    }
  }

  Future<void> saveTokens(LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', loginResponse.access);
    await prefs.setString('refresh_token', loginResponse.refresh);
    await prefs.setString('session_id', loginResponse.sessionId);
  }

  Future<void> logout() async {
    // Tokenlarni o'chirish
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('session_id');

    state = AuthState(status: AuthStatus.unauthenticated);
  }
}

// auth_provider.dart
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
