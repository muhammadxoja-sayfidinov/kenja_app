import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/exercise_model.dart';
import '../models/workout_categories.dart';

class WorkoutService {
  static const String baseCategoryUrl =
      'https://owntrainer.uz/api/exercise/api/workout-categories/';
  static const String baseExerciseUrl =
      'https://owntrainer.uz/api/exercise/api/exercises/by-category/';

  Future<String> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    if (accessToken == null) {
      throw Exception('Foydalanuvchi autentifikatsiya qilmagan');
    }
    return accessToken;
  }

  /// Kategoriyalarni olib kelish
  Future<List<WorkoutCategory>> fetchWorkoutCategories() async {
    final accessToken = await _getAccessToken();

    final uri = Uri.parse(baseCategoryUrl);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> categoriesJson = decoded['workout_categories'] ?? [];
      final categories = categoriesJson
          .map((catJson) => WorkoutCategory.fromJson(catJson))
          .toList();
      return categories;
    } else {
      throw Exception('Kategoriyalarni yuklab bo‘lmadi');
    }
  }

  /// Ma’lum bir `category_id` bo‘yicha mashqlarni olib kelish
  Future<List<Exercise>> fetchExercisesByCategory(int categoryId) async {
    final accessToken = await _getAccessToken();

    final uri = Uri.parse('$baseExerciseUrl?category_id=$categoryId');
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> exercisesJson = decoded['exercises'] ?? [];
      final exercises =
          exercisesJson.map((exJson) => Exercise.fromJson(exJson)).toList();
      return exercises;
    } else {
      throw Exception('Mashqlarni yuklab bo‘lmadi');
    }
  }
}
