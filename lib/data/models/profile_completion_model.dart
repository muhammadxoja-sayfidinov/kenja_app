// models/profile_completion_model.dart
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

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'goal': goal,
      'level': level,
    };
  }
}
