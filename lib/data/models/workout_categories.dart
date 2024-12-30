class WorkoutCategory {
  final int id;
  final String categoryName;
  final String description;

  WorkoutCategory({
    required this.id,
    required this.categoryName,
    required this.description,
  });

  factory WorkoutCategory.fromJson(Map<String, dynamic> json) {
    // Agar workout_category key mavjud bo'lsa (detail API uchun)
    final data =
        json.containsKey('workout_category') ? json['workout_category'] : json;

    return WorkoutCategory(
      id: data['id'],
      categoryName: data['category_name'],
      description: data['description'],
    );
  }

  // List uchun helper method
  static List<WorkoutCategory> fromJsonList(Map<String, dynamic> json) {
    final list = json['workout_categories'] as List;
    return list.map((item) => WorkoutCategory.fromJson(item)).toList();
  }
}
