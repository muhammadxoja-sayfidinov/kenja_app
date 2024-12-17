class Meal {
  final int id;
  final String mealType;
  final String foodName;
  final double calories;
  final double waterContent;
  final int preparationTime;
  final String foodPhoto;

  Meal({
    required this.id,
    required this.mealType,
    required this.foodName,
    required this.calories,
    required this.waterContent,
    required this.preparationTime,
    required this.foodPhoto,
  });

  // JSON'dan obyektga
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      mealType: json['meal_type'],
      foodName: json['food_name'],
      calories: double.parse(json['calories'].toString()),
      waterContent: double.parse(json['water_content'].toString()),
      preparationTime: json['preparation_time'],
      foodPhoto: json['food_photo'],
    );
  }

  // Obyektdan JSON'ga
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_type': mealType,
      'food_name': foodName,
      'calories': calories,
      'water_content': waterContent,
      'preparation_time': preparationTime,
      'food_photo': foodPhoto,
    };
  }
}

class MealDetail {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  MealDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}
