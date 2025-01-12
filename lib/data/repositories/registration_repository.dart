// lib/repositories/registration_repository.dart

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth/register_initial_model.dart';

class RegistrationRepository {
  final String baseUrl;

  RegistrationRepository({required this.baseUrl});

  /// Ro'yxatdan o'tish (initial)
  Future<RegisterResponse> registerInitial(RegisterInitialModel request) async {
    final url = Uri.parse('$baseUrl/users/register/initial/');

    final Map<String, String> body = {
      'first_name': request.firstName,
      'last_name': request.lastName,
      'email_or_phone': request.emailOrPhone,
      'password': request.password,
    };

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    // 200 va 201 ikkalasi ham muvaffaqiyatli
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

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

  /// Tasdiqlash kodi yuborish
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
