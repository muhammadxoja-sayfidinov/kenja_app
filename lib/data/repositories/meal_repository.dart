import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../config/constants.dart';
import '../models/meal_model.dart';

class MealsService {
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  MealsService(
    this.baseUrl,
    this.secureStorage,
  );

  /// API’dan “meals” ma’lumotlarini olib kelish funksiyasi
  Future<List<Meal>> fetchMeals() async {
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);

    final response = await http.get(
      Uri.parse('$baseUrl/food/api/meals/'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      final List<dynamic> mealsJson = decodedData['meals'] ?? [];
      final meals =
          mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
      return meals;
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<void> completeMeal(int sessionId, int mealId) async {
    final accessToken = await secureStorage.read(key: Constants.accessTokenKey);

    final response = await http.post(
      Uri.parse('$baseUrl/food/api/meal/complete/'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'session_id': sessionId,
        'meal_id': mealId,
      }),
    );

    if (response.statusCode == 200) {
      // Javobni qayta ishlash
      print('Meal completed successfully');
    } else {
      // Xatolikni qayta ishlash
      throw Exception('Failed to complete meal');
    }
  }
}
