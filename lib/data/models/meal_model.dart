class Meal {
  final int id;
  final String mealType;
  final String foodName;
  final String calories;
  final String waterContent;
  final int preparationTime;
  final String foodPhoto;
  final List<Preparation> preparations;

  Meal({
    required this.id,
    required this.mealType,
    required this.foodName,
    required this.calories,
    required this.waterContent,
    required this.preparationTime,
    required this.foodPhoto,
    required this.preparations,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] ?? 0,
      mealType: json['meal_type'] ?? '',
      foodName: json['food_name'] ?? '',
      calories: json['calories'] ?? '',
      waterContent: json['water_content'] ?? '',
      preparationTime: json['preparation_time'] ?? 0,
      foodPhoto: json['food_photo'] ?? '',
      preparations: (json['preparations'] as List<dynamic>?)
              ?.map((prepJson) => Preparation.fromJson(prepJson))
              .toList() ??
          [],
    );
  }
}

class Preparation {
  final int id;
  final int meal;
  final String name;
  final String description;
  final int preparationTime;
  final String calories;
  final String waterUsage;
  final String videoUrl;
  final List<StepModel> steps;

  Preparation({
    required this.id,
    required this.meal,
    required this.name,
    required this.description,
    required this.preparationTime,
    required this.calories,
    required this.waterUsage,
    required this.videoUrl,
    required this.steps,
  });

  factory Preparation.fromJson(Map<String, dynamic> json) {
    return Preparation(
      id: json['id'] ?? 0,
      meal: json['meal'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      preparationTime: json['preparation_time'] ?? 0,
      calories: json['calories'] ?? '',
      waterUsage: json['water_usage'] ?? '',
      videoUrl: json['video_url'] ?? '',
      steps: (json['steps'] as List<dynamic>?)
              ?.map((stepJson) => StepModel.fromJson(stepJson))
              .toList() ??
          [],
    );
  }
}

class StepModel {
  final int id;
  final int preparation;
  final String title;
  final String text;
  final String stepTime;
  final int stepNumber;
  final String titleUz;
  final String titleRu;
  final String titleEn;
  final String textUz;
  final String textRu;
  final String textEn;

  StepModel({
    required this.id,
    required this.preparation,
    required this.title,
    required this.text,
    required this.stepTime,
    required this.stepNumber,
    required this.titleUz,
    required this.titleRu,
    required this.titleEn,
    required this.textUz,
    required this.textRu,
    required this.textEn,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      id: json['id'] ?? 0,
      preparation: json['preparation'] ?? 0,
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      stepTime: json['step_time'] ?? '',
      stepNumber: json['step_number'] ?? 0,
      titleUz: json['title_uz'] ?? '',
      titleRu: json['title_ru'] ?? '',
      titleEn: json['title_en'] ?? '',
      textUz: json['text_uz'] ?? '',
      textRu: json['text_ru'] ?? '',
      textEn: json['text_en'] ?? '',
    );
  }
}
