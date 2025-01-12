// lib/data/repositories/user_repository.dart

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../config/constants.dart';
import '../models/auth/login.dart';
import '../models/auth/profile_completion_model.dart';
import '../models/auth/register_initial_model.dart';
import '../models/user_profile.dart';

class UserRepository {
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  UserRepository({
    required this.baseUrl,
    required this.secureStorage,
  });

  /// Ro'yxatdan o'tish (initial)
  Future<int> registerInitial(RegisterInitialModel model) async {
    final Map<String, String> body = {
      'first_name': model.firstName,
      'last_name': model.lastName,
      'email_or_phone': model.emailOrPhone,
      'password': model.password,
    };
    final url = Uri.parse('$baseUrl/api/users/register/initial/');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['user_id']; // Serverdan qaytgan ID
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  /// Tasdiqlash kodi yuborish
  Future<VerifyCodeResponse> verifyCode(int userId, String code) async {
    final body = {
      "user_id": userId.toString(),
      "code": code,
    };
    final url = Uri.parse('$baseUrl/api/users/verify-code/');
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
      throw Exception('Failed to verify code: ${response.body}');
    }
  }

  /// Login qilish
  Future<LoginResponse> login(String emailOrPhone, String password) async {
    final url = Uri.parse('$baseUrl/api/users/login/');
    final body = jsonEncode({
      'email_or_phone': emailOrPhone,
      'password': password,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['detail'] ?? 'Login failed');
    }
  }

  /// Tokenni yangilash
  Future<LoginResponse> refreshToken(String refreshToken) async {
    final url = Uri.parse('$baseUrl/api/token/refresh/');
    final body = jsonEncode({'refresh': refreshToken});

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Failed to refresh token: ${response.body}');
    }
  }

  /// Profilni to'ldirish
  Future<void> completeProfile(ProfileCompletionModel model) async {
    final url = Uri.parse('$baseUrl/api/users/profile/complete/');
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
      body: model.toFormData(), // toFormData() Map<String, String> qaytaradi
    );

    print('Yuborilayotgan ma’lumotlar: ${model.toFormData()}');
    print(response.statusCode);
    print('Server javobi: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to complete profile: ${response.body}');
    }
  }

  /// Profil ma'lumotlarini olish
  Future<UserProfile> getUserProfile() async {
    final url = Uri.parse('$baseUrl/api/users/profile/');
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to fetch user profile: ${response.body}');
    }
  }

  /// Profilni yangilash
  Future<void> updateProfile(ProfileCompletionModel model) async {
    final url = Uri.parse('$baseUrl/api/users/profile/update/');
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
      body: jsonEncode(model.toFormData()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }
}
