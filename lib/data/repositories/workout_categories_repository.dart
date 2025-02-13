import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../config/constants.dart';
import '../models/exercise_model.dart';
import '../models/workout_categories.dart';

class WorkoutService {
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  WorkoutService(this.baseUrl, this.secureStorage);

  /// Kategoriyalarni olib kelish
  Future<List<WorkoutCategory>> fetchWorkoutCategories() async {
    final uri = Uri.parse('$baseUrl/exercise/api/workout-categories/');
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);
    ;
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
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);
    final uri = Uri.parse(
        '$baseUrl/exercise/api/exercises/by-category/?category_id=$categoryId');
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

  Future<void> completeExercise(int sessionId, int exerciseId) async {
    print(sessionId);
    print(exerciseId);
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);

    final response = await http.post(
      Uri.parse('https://owntrainer.uz/api/exercise/api/start-exercise/'),
      // ← o‘zgardi!
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"session_id": 3, "exercise_id": exerciseId}),
    );
    print(response.statusCode);
    print(response.body); // Xatolik tafsilotini ko‘rish uchun

    if (response.statusCode == 200) {
      print('Exercise started successfully');
    } else {
      throw Exception('Failed to start Exercise: ${response.body}');
    }
  }
}
