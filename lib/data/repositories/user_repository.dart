// lib/data/repositories/user_repository.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constants.dart';
import '../models/profile_completion_model.dart';
import '../models/register_initial_model.dart';
import '../models/user_profile.dart';
import '../models/verify_code_response.dart';

class UserRepository {
  final String baseUrl;

  UserRepository({
    required this.baseUrl,
  });

  // Ro'yxatdan o'tish
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

  // Tasdiqlash
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
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return VerifyCodeResponse.fromJson(data);
    } else {
      throw Exception('Failed to verify code: ${response.body}');
    }
  }

  // Profilni to'ldirish
  Future<void> completeProfile(ProfileCompletionModel model) async {
    final url = Uri.parse('$baseUrl/api/users/profile/complete/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(Constants.accessTokenKey);

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to complete profile: ${response.body}');
    }
  }

  // Profil ma'lumotlarini olish
  Future<UserProfile> getUserProfile() async {
    final url = Uri.parse('$baseUrl/api/users/profile/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(Constants.accessTokenKey);

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

  // Profilni yangilash
  Future<void> updateProfile(ProfileCompletionModel model) async {
    final url = Uri.parse('$baseUrl/api/users/profile/update/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(Constants.accessTokenKey);

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
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }
}
