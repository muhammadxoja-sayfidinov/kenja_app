// lib/data/models/profile_completion_model.dart

class ProfileCompletionModel {
  String? gender;
  int? age;
  double? height;
  double? weight;
  String? goal;
  String? level;

  ProfileCompletionModel({
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.goal,
    this.level,
  });

  Map<String, String> toFormData() {
    return {
      'gender': gender.toString(),
      'country': 'Uzbekistan',
      'age': age.toString(),
      'height': height.toString(),
      'weight': weight.toString(),
      'goal': goal.toString(),
      'level': level.toString(),
    };
  }

  factory ProfileCompletionModel.fromJson(Map<String, dynamic> json) {
    return ProfileCompletionModel(
      gender: json['gender'],
      age: json['age'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      goal: json['goal'],
      level: json['level'],
    );
  }
}
