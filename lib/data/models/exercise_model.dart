class Exercise {
  final int id;
  final int category;
  final String name;
  final String description;
  final String exerciseTime;
  final String difficultyLevel;
  final String videoUrl;
  final String targetMuscle;

  Exercise({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.exerciseTime,
    required this.difficultyLevel,
    required this.videoUrl,
    required this.targetMuscle,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? 0,
      category: json['category'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      exerciseTime: json['exercise_time'] ?? '',
      difficultyLevel: json['difficulty_level'] ?? '',
      videoUrl: json['video_url'] ?? '',
      targetMuscle: json['target_muscle'] ?? '',
    );
  }
}
