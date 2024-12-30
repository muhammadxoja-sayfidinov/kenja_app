import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal.dart.dart';
import '../models/session.dart';
import '../models/workout_categories.dart';

class SessionRepository {
  final String baseUrl = "https://owntrainer.uz/api/exercise/api";
  final String mealBaseUrl = "https://owntrainer.uz/api/food/api";

  Future<Map<String, String>> _getHeaders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('Token topilmadi. Iltimos, qaytadan tizimga kiring');
      }

      return {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
    } catch (e) {
      throw Exception('Autentifikatsiya xatoligi: $e');
    }
  }

  Future<List<Session>> fetchSessions() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/sessions/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey("sessions")) {
          final List<dynamic> data = responseData["sessions"];
          return data.map((session) => Session.fromJson(session)).toList();
        } else {
          throw Exception("API javobida 'sessions' maydoni topilmadi");
        }
      } else if (response.statusCode == 401) {
        throw Exception("Sizning sessiyangiz eskirgan. Qaytadan kiring");
      } else {
        throw Exception("Server xatoligi: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Ma'lumotlarni yuklashda xatolik: $e");
    }
  }

  Future<WorkoutCategory> fetchWorkoutById(int id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/workout-categories/$id/'),
        headers: headers,
      );

      print('Workout Response (ID: $id): ${response.body}'); // Debug uchun

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Parsed Response Data: $responseData'); // Debug uchun
        return WorkoutCategory.fromJson(responseData);
      } else {
        print('Error Status Code: ${response.statusCode}'); // Debug uchun
        throw Exception("Workout yuklashda xatolik: ${response.statusCode}");
      }
    } catch (e) {
      print('Exception while fetching workout: $e'); // Debug uchun
      throw Exception("Workout ma'lumotlarini yuklashda xatolik: $e");
    }
  }

  Future<Meal> fetchMealById(int id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$mealBaseUrl/meals/$id/'),
        headers: headers,
      );

      print('Meal Response (ID: $id): ${response.body}'); // Debug uchun

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Parsed Meal Data: $responseData'); // Debug uchun
        return Meal.fromJson(responseData);
      } else {
        print(
            'Error Status Code for Meal: ${response.statusCode}'); // Debug uchun
        throw Exception("Taom yuklashda xatolik: ${response.statusCode}");
      }
    } catch (e) {
      print('Exception while fetching meal: $e'); // Debug uchun
      throw Exception("Taom ma'lumotlarini yuklashda xatolik: $e");
    }
  }
}
