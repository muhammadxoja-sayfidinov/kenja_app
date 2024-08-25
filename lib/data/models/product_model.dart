class Workout {
  final String title;
  final String description;
  final String duration;
  final int calories;
  final String waterIntake;
  final List<Exercise> exercises;

  Workout({
    required this.title,
    required this.description,
    required this.duration,
    required this.calories,
    required this.waterIntake,
    required this.exercises,
  });
}

class Exercise {
  final String title;
  final String description;
  final String imagePath;
  final String duration;

  Exercise({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.duration,
  });
}

class Profile {
  String name;
  String email;
  String phoneNumber;

  Profile({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class UserProfile {
  String gender;
  int age;
  int height;
  int weight;
  String goal;
  String level;

  UserProfile({
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.level,
  });
}
