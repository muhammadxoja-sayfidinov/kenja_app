// lib/data/models/user_profile.dart
class UserProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String emailOrPhone;
  final String? phoneOrEmailOptional;
  final String gender;
  final String country;
  final int age;
  final double height;
  final double weight;
  final String goal;
  final String level;
  final bool isPremium;
  final String? photo;
  final String language;
  final DateTime dateJoined;
  final bool isActive;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.emailOrPhone,
    this.phoneOrEmailOptional,
    required this.gender,
    required this.country,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.level,
    required this.isPremium,
    this.photo,
    required this.language,
    required this.dateJoined,
    required this.isActive,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      emailOrPhone: json['email_or_phone'],
      phoneOrEmailOptional: json['phone_or_email_optional'],
      gender: json['gender'],
      country: json['country'],
      age: json['age'],
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      goal: json['goal'],
      level: json['level'],
      isPremium: json['is_premium'],
      photo: json['photo'],
      language: json['language'],
      dateJoined: DateTime.parse(json['date_joined']),
      isActive: json['is_active'],
    );
  }
}
