import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal_model.dart';
import '../models/session_model.dart';
import '../models/workout_categories.dart';

Future<String> _getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  if (accessToken == null) {
    throw Exception('Foydalanuvchi autentifikatsiya qilmagan');
  }
  return accessToken;
}

class SessionRepository {
  final String baseUrl;

  SessionRepository({required this.baseUrl});

  Future<List<Session>> fetchSessions() async {
    final accessToken = await _getAccessToken();

    final url = Uri.parse('$baseUrl/exercise/api/sessions/');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final sessionsJson = data['sessions'] as List<dynamic>;
      return sessionsJson.map((e) => Session.fromJson(e)).toList();
    } else {
      throw Exception('Sessionsni o‘qishda xatolik: ${response.statusCode}');
    }
  }
}

class WorkoutCategoryRepository {
  final String baseUrl;

  WorkoutCategoryRepository({required this.baseUrl});

  /// Masalan, bitta ID ga ko‘ra olmoqchi bo‘lsak:
  Future<WorkoutCategory> fetchWorkoutCategoryById(int id) async {
    final accessToken = await _getAccessToken();
    final url = Uri.parse('$baseUrl/exercise/api/workout-categories/$id/');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WorkoutCategory.fromJson(data['workout_category']);
    } else {
      throw Exception('WorkoutCategoryni o‘qishda xatolik');
    }
  }
}

class MealRepository {
  final String baseUrl;

  MealRepository({required this.baseUrl});

  Future<Meal> fetchMealById(int id) async {
    final accessToken = await _getAccessToken();
    final url = Uri.parse('$baseUrl/food/api/meals/$id/');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Meal.fromJson(data['meal']);
    } else {
      throw Exception('Mealni o‘qishda xatolik');
    }
  }
}
