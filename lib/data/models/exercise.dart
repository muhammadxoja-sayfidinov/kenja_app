class Exercise {
  final int id;
  final int category;
  final String name;
  final String description;
  final String exerciseTime;
  final String difficultyLevel;
  final String videoUrl;
  final String targetMuscle;
  final DateTime createdAt;
  final DateTime updatedAt;

  Exercise({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.exerciseTime,
    required this.difficultyLevel,
    required this.videoUrl,
    required this.targetMuscle,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON'dan obyektga
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      description: json['description'],
      exerciseTime: json['exercise_time'],
      difficultyLevel: json['difficulty_level'],
      videoUrl: json['video_url'],
      targetMuscle: json['target_muscle'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Obyektdan JSON'ga
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'description': description,
      'exercise_time': exerciseTime,
      'difficulty_level': difficultyLevel,
      'video_url': videoUrl,
      'target_muscle': targetMuscle,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ExerciseDetail {
  final int id;
  final String name;
  final String description;
  final String videoUrl;

  ExerciseDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.videoUrl,
  });

  // JSON'dan obyektga
  factory ExerciseDetail.fromJson(Map<String, dynamic> json) {
    return ExerciseDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      videoUrl: json['video_url'],
    );
  }

  // Obyektdan JSON'ga
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'video_url': videoUrl,
    };
  }
}
