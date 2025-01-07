// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../models/exercise_model.dart';
//
// class ExerciseRepository {
//   final String baseUrl = 'https://owntrainer.uz/api/exercise/api';
//
//   Future<List<ExerciseModel>> fetchExercises() async {
//     final url = Uri.parse('$baseUrl/exercises/');
//     final response = await http.get(url);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> exercisesJson = data['exercises'] ?? [];
//       return exercisesJson.map((json) => ExerciseModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load exercises');
//     }
//   }
//
//   Future<ExerciseModel> fetchExerciseById(int exerciseId) async {
//     final url = Uri.parse('$baseUrl/exercises/$exerciseId/');
//     final response = await http.get(url);
//     print(response.statusCode);
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       // API javobi: { "exercise": {...} }
//       final exerciseJson = data['exercise'];
//       return ExerciseModel.fromJson(exerciseJson);
//     } else {
//       throw Exception('Failed to load exercise by id');
//     }
//   }
// }
