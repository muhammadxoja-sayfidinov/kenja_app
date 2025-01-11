// // lib/providers/auth_provider.dart
//
// import 'dart:convert';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../config/constants.dart';
// import '../models/login.dart';
// import '../models/register.dart';
// import '../models/register_initial_model.dart';
// import '../repositories/user_repository.dart';
//
// enum AuthStatus {
//   unauthenticated,
//   authenticating,
//   authenticated,
//   registering,
//   verifying,
//   error
// }
//
// class AuthState {
//   final AuthStatus status;
//   final LoginResponse? loginResponse;
//   final String? errorMessage;
//
//   AuthState({
//     required this.status,
//     this.loginResponse,
//     this.errorMessage,
//   });
//
//   AuthState copyWith({
//     AuthStatus? status,
//     LoginResponse? loginResponse,
//     String? errorMessage,
//   }) {
//     return AuthState(
//       status: status ?? this.status,
//       loginResponse: loginResponse ?? this.loginResponse,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
// }
//
// class AuthNotifier extends StateNotifier<AuthState> {
//   final UserRepository _userRepository;
//
//   AuthNotifier(this._userRepository)
//       : super(AuthState(status: AuthStatus.unauthenticated)) {
//     _checkAuthentication();
//   }
//
//   // Avvaldan autentifikatsiya holatini tekshirish
//   Future<void> _checkAuthentication() async {
//     final prefs = await SharedPreferences.getInstance();
//     final accessToken = prefs.getString(Constants.accessTokenKey);
//     final refreshToken = prefs.getString(Constants.refreshTokenKey);
//     if (accessToken != null && refreshToken != null) {
//       state = AuthState(
//         status: AuthStatus.authenticated,
//         loginResponse: LoginResponse(
//           message: 'Already logged in',
//           access: accessToken,
//           refresh: refreshToken,
//         ),
//       );
//     } else {
//       state = AuthState(status: AuthStatus.unauthenticated);
//     }
//   }
//
//   // Headerlarni olish
//   Future<Map<String, String>> _getHeaders(
//       Map<String, String>? additionalHeaders) async {
//     final prefs = await SharedPreferences.getInstance();
//     final accessToken = prefs.getString(Constants.accessTokenKey);
//
//     final Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//
//     if (accessToken != null && accessToken.isNotEmpty) {
//       headers['Authorization'] = 'Bearer $accessToken';
//     }
//
//     if (additionalHeaders != null) {
//       headers.addAll(additionalHeaders);
//     }
//
//     return headers;
//   }
//
//   // Login funksiyasi
//   // Future<void> login(String emailOrPhone, String password) async {
//   //   final url = Uri.parse('${Constants.baseUrl}/api/users/login/');
//   //   try {
//   //     state = state.copyWith(status: AuthStatus.authenticating);
//   //
//   //     final response = await http.post(
//   //       url,
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Accept': 'application/json',
//   //       },
//   //       body:
//   //           jsonEncode({'email_or_phone': emailOrPhone, 'password': password}),
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //       final loginResponse = LoginResponse.fromJson(data);
//   //       await saveTokens(loginResponse);
//   //
//   //       state = state.copyWith(
//   //         status: AuthStatus.authenticated,
//   //         loginResponse: loginResponse,
//   //       );
//   //     } else {
//   //       final errorData = jsonDecode(response.body);
//   //       state = state.copyWith(
//   //         status: AuthStatus.error,
//   //         errorMessage: errorData['detail'] ?? 'Kirish muvaffaqiyatsiz bo\'ldi',
//   //       );
//   //     }
//   //   } catch (e) {
//   //     state = state.copyWith(
//   //       status: AuthStatus.error,
//   //       errorMessage: 'Xatolik yuz berdi: $e',
//   //     );
//   //   }
//   // }
//
//   // Register Initial funksiyasi
//
//   // HTTP POST So'rovini Yuborish (Optional)
//   // Future<http.Response> post(
//   //   String endpoint,
//   //   dynamic body, {
//   //   Map<String, String>? headers,
//   // }) async {
//   //   return _sendRequest(() async => http.post(
//   //         Uri.parse("${Constants.baseUrl}$endpoint"),
//   //         body: jsonEncode(body),
//   //         headers: await _getHeaders(headers),
//   //       ));
//   // }
//
//   // HTTP GET So'rovini Yuborish (Optional)
//   // Future<http.Response> get(
//   //   String endpoint, {
//   //   Map<String, String>? headers,
//   // }) async {
//   //   return _sendRequest(() async => http.get(
//   //         Uri.parse("${Constants.baseUrl}$endpoint"),
//   //         headers: await _getHeaders(headers),
//   //       ));
//   // }
//
//   // So'rovlarni yuborish va tokenni yangilash
//   // Future<http.Response> _sendRequest(
//   //     Future<http.Response> Function() request) async {
//   //   try {
//   //     final response = await request();
//   //
//   //     if (response.statusCode == 401) {
//   //       // Token muddati tugagan, yangilashga harakat qilish
//   //       final refreshSuccess = await _refreshToken();
//   //
//   //       if (refreshSuccess) {
//   //         // Yangilangan token bilan original so'rovni qayta yuborish
//   //         return await request();
//   //       }
//   //     }
//   //
//   //     return response;
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
//
//
// // AuthProvider
// final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   final userRepository = UserRepository(baseUrl: Constants.baseUrl);
//   return AuthNotifier(userRepository);
// });
