import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kenja_app/data/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserRepository {
  final String baseUrl =
      "https://makhteachenglish.pythonanywhere.com/api/users/profile/";

  Future<User> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM0NTA0ODYyLCJpYXQiOjE3MzQ1MDEyNjIsImp0aSI6IjJiYjgyNWUwNzFhMzQ0ZTBhMTAyOWEzNGVkZDQ5ODVjIiwidXNlcl9pZCI6MX0.2TArBamt8t0bEbNCr2RzfwwCF1wVlPntAW0d-65jIx4';


    if (accessToken == null) {
      throw Exception('Foydalanuvchi autentifikatsiya qilmagan');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken', // Tokenni yuboring
      },


    );
    print(response.body);
    print(response.runtimeType);

    if (response.statusCode == 200) {

      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return User.fromJson(data);

    } else {
      throw Exception("Failed to load USER. Status: ${response.statusCode}");
    }
  }

  Future<String?> Put(Map<String, String> params)async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    // Agar access token bo'lmasa, autentifikatsiya qiling
    if (accessToken == null) {
      throw Exception('Foydalanuvchi autentifikatsiya qilmagan');
    }
    try{
        final response = await http.put(
          Uri.parse(baseUrl),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken', // Tokenni yuboring
          },
          body: jsonEncode(params)
        );
        if (response.statusCode == 200 ) {
          print("Yangilandi");

          return response.toString();
        }

  }catch(e){
        print(e);
    }
    return null;
}

  static Map<String, String> paramsUpdate(User user) {
    return {
      'id': user.id.toString(),
      "first_name": user.firstName,
      "last_name": user.lastName,
      "email_or_phone": user.emailOrPhone,
      "gender": user.gender,
      "country": user.country,
      "age": user.age.toString(),
      "height": user.height.toString(),
      "weight": user.weight.toString(),
      "goal": user.goal,
      "level": user.level,
      "is_premium": user.isPremium.toString(),
      "photo": user.photo,
      "language": user.language,
      "date_joined": user.dateJoined.toIso8601String(),
      "is_active": user.isActive.toString(),
    };
  }
}