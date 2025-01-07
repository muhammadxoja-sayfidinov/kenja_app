class WorkoutCategory {
  final int id;
  final String categoryName;
  final String description;
  final String? workoutImage;

  WorkoutCategory({
    required this.id,
    required this.categoryName,
    required this.description,
    this.workoutImage,
  });

  factory WorkoutCategory.fromJson(Map<String, dynamic> json) {
    return WorkoutCategory(
      id: json['id'] ?? 0,
      categoryName: json['category_name'] ?? '',
      description: json['description'] ?? '',
      workoutImage: json['workout_image'],
    );
  }
}
