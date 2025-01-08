// repositories/registration_repository.dart

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/register.dart';

class RegistrationRepository {
  final String baseUrl;

  RegistrationRepository({required this.baseUrl});

  /// POST /api/users/register/initial/
  /// Body: { "first_name": ..., "last_name": ..., "email_or_phone": ..., "password": ... }
  Future<RegisterResponse> registerInitial(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/users/register/initial/');

    final Map<String, String> body = {
      'first_name': request.firstName,
      'last_name': request.lastName,
      'email_or_phone': request.emailOrPhone,
      'password': request.password,
    };

    print('Request body: $body');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // 200 va 201 ikkalasi ham muvaffaqiyatli
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      print('Response data: $data');

      // Agar xabar "Verification code resent" bo'lsa, bu yangi registratsiya emas
      if (data['message']?.toLowerCase().contains('resent') == true) {
        // `user_id` mavjud bo'lsa, uni oling, aks holda 0 qiling
        return RegisterResponse(
          userId: data['user_id'] ?? data['id'] ?? 0,
          message: data['message'] ?? 'Verification code resent.',
        );
      }

      return RegisterResponse.fromJson(data);
    } else {
      final errorData = jsonDecode(response.body);
      final msg = errorData['message'] ?? 'Ro\'yxatdan o\'tishda xatolik';
      throw Exception(msg);
    }
  }

  /// POST /api/users/verify-code/
  /// Body: { "user_id": 4, "code": "1046" }
  Future<VerifyCodeResponse> verifyCode(int userId, String code) async {
    final url = Uri.parse('$baseUrl/users/verify-code/');
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

    print('Verify Code Response status: ${response.statusCode}');
    print('Verify Code Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return VerifyCodeResponse.fromJson(data);
    } else {
      final errorData = jsonDecode(response.body);
      final msg = errorData['message'] ?? 'Tasdiqlashda xatolik';
      throw Exception(msg);
    }
  }
}
