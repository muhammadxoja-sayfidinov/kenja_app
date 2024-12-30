import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal.dart.dart';

class MealRepository {
  final String baseUrl = "https://owntrainer.uz/api/food/api/meals/";

  Future<List<Meal>> fetchMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    // Agar access token bo'lmasa, autentifikatsiya qiling
    if (accessToken == null) {
      throw Exception('Foydalanuvchi autentifikatsiya qilmagan');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    print(jsonDecode(response.body)["meals"]);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)["meals"];
      return data.map((meal) => Meal.fromJson(meal)).toList();
    } else {
      throw Exception("Failed to load meals. Status: ${response.statusCode}");
    }
  }
}
