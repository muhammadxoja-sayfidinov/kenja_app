import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kenja_app/data/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final String baseUrl = "https://owntrainer.uz/api/users/profile/";

  // Foydalanuvchi ma'lumotlarini olish
  Future<User> fetchUser() async {
    final accessToken = await _getAccessToken();
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: _buildHeaders(accessToken),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return User.fromJson(data);
      } else if (response.statusCode == 403) {
        throw Exception("403 xatolik: Ruxsat etilmagan so‘rov.");
      } else {
        throw Exception("Xatolik yuz berdi: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    }
  }

  // Foydalanuvchi ma'lumotlarini yangilash
  Future<bool> updateUser(User user) async {
    final accessToken = await _getAccessToken();
    final params = _paramsFromUser(user);

    try {
      final response = await http.put(
        Uri.parse(baseUrl),
        headers: _buildHeaders(accessToken),
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Tokenni olish
  Future<String> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    if (accessToken == null) {
      throw Exception('Foydalanuvchi autentifikatsiya qilmagan');
    }
    return accessToken;
  }

  // Headerlarni yaratish
  Map<String, String> _buildHeaders(String accessToken) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
  }

  // Foydalanuvchi obyektidan parametrlarni yaratish
  Map<String, dynamic> _paramsFromUser(User user) {
    return {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "email_or_phone": user.emailOrPhone,
      "gender": user.gender,
      "country": user.country,
      "age": user.age,
      "height": user.height,
      "weight": user.weight,
      "goal": user.goal,
      "level": user.level,
      "is_premium": user.isPremium,
      "photo": user.photo,
      "language": user.language,
      "is_active": user.isActive,
    };
  }
}
