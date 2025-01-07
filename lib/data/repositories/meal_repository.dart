import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal_model.dart';

class MealsService {
  static const String baseUrl = 'https://owntrainer.uz/api/food/api/meals/';

  Future<String> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    if (accessToken == null) {
      throw Exception('Foydalanuvchi autentifikatsiya qilmagan');
    }
    return accessToken;
  }

  /// API’dan “meals” ma’lumotlarini olib kelish funksiyasi
  Future<List<Meal>> fetchMeals() async {
    final accessToken = await _getAccessToken();

    final response = await http.get(
      Uri.parse(baseUrl),
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
}
