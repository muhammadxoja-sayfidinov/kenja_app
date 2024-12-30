import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout_categories.dart';

class WorkoutCategoryRepository {
  final String baseUrl =
      "https://owntrainer.uz/api/exercise/api/workout-categories/";

  Future<List<WorkoutCategory>> fetchWorkoutCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    // Check if access token exists
    if (accessToken == null) {
      throw Exception('User is not authenticated');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body)["workout_categories"];
      return data
          .map((category) => WorkoutCategory.fromJson(category))
          .toList();
    } else {
      throw Exception(
          "Failed to load workout categories. Status: ${response.statusCode}");
    }
  }
}
