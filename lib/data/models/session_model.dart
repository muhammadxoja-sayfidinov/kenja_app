import 'package:kenja_app/data/models/workout_categories.dart';

import 'meal_model.dart';

/// Session modeli
class Session {
  final int id;
  final String? coverImage;
  final int? program;
  final String caloriesBurned;
  final String sessionTime;
  final int sessionNumber;
  final List<int> exercises; // [2, 3, ...] kabi IDlar
  final List<int> meals; // [2, 5, ...] kabi IDlar

  Session({
    required this.id,
    this.coverImage,
    this.program,
    required this.caloriesBurned,
    required this.sessionTime,
    required this.sessionNumber,
    required this.exercises,
    required this.meals,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] ?? 0,
      coverImage: json['cover_image'],
      program: json['program'],
      caloriesBurned: json['calories_burned'] ?? '',
      sessionTime: json['session_time'] ?? '',
      sessionNumber: json['session_number'] ?? 0,
      exercises:
          (json['exercises'] as List<dynamic>).map((e) => e as int).toList(),
      meals: (json['meals'] as List<dynamic>).map((m) => m as int).toList(),
    );
  }
}

class SessionDetail {
  final Session session;
  final List<WorkoutCategory>
      workoutCategories; // session.exercises dagi IDlardan kelgan ma’lumotlar
  final List<Meal> meals; // session.meals dagi IDlardan kelgan ma’lumotlar

  SessionDetail({
    required this.session,
    required this.workoutCategories,
    required this.meals,
  });
}
