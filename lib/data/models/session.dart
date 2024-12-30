class Session {
  final int id;
  final int program;
  final String caloriesBurned;
  final int sessionNumber;
  final String sessionTime;
  final List<int> exercises;
  final List<int> meals;

  Session({
    required this.id,
    required this.program,
    required this.caloriesBurned,
    required this.sessionNumber,
    required this.sessionTime,
    required this.exercises,
    required this.meals,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as int,
      program: json['program'] as int,
      caloriesBurned: json['calories_burned'] as String,
      sessionNumber: json['session_number'] as int,
      sessionTime: json['session_time'] as String,
      exercises: List<int>.from(json['exercises'] as List),
      meals: List<int>.from(json['meals'] as List),
    );
  }
}
