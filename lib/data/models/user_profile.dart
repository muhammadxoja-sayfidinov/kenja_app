// lib/data/models/user_profile.dart

class UserProfile {
  final String firstName;
  final String lastName;
  final String emailOrPhone;
  final String? photo;
  final String gender;
  final String country;
  final int age;
  final double height;
  final double weight;
  final String goal;
  final String level;
  final String language;
  final bool isPremium;
  final DateTime dateJoined;
  final bool isActive;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.emailOrPhone,
    this.photo,
    required this.gender,
    required this.country,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.level,
    required this.language,
    required this.isPremium,
    required this.dateJoined,
    required this.isActive,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      emailOrPhone: json['email_or_phone'] ?? '',
      photo: json['photo'],
      gender: json['gender'] ?? '',
      country: json['country'] ?? '',
      age: json['age'] ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      goal: json['goal'] ?? '',
      level: json['level'] ?? '',
      language: json['language'] ?? '',
      isPremium: json['is_premium'] ?? false,
      dateJoined: DateTime.parse(json['date_joined']),
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email_or_phone': emailOrPhone,
      'photo': photo,
      'gender': gender,
      'country': country,
      'age': age,
      'height': height,
      'weight': weight,
      'goal': goal,
      'level': level,
      'language': language,
      'is_premium': isPremium,
      'date_joined': dateJoined.toIso8601String(),
      'is_active': isActive,
    };
  }
}
