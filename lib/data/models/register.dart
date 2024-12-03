class RegisterRequest {
  final String firstName;
  final String lastName;
  final String emailOrPhone;
  final String password;
  final String gender;
  final String country;
  final int age;
  final int height;
  final int weight;
  final String level;
  final String goal;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.emailOrPhone,
    required this.password,
    required this.gender,
    required this.country,
    required this.age,
    required this.height,
    required this.weight,
    required this.level,
    required this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email_or_phone': emailOrPhone,
      'password': password,
      'gender': gender,
      'country': country,
      'age': age,
      'height': height,
      'weight': weight,
      'level': level,
      'goal': goal,
    };
  }
}
