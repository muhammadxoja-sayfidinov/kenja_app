// lib/data/models/register_initial_model.dart

class RegisterInitialModel {
  final String firstName;
  final String lastName;
  final String emailOrPhone;
  final String password;

  RegisterInitialModel({
    required this.firstName,
    required this.lastName,
    required this.emailOrPhone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email_or_phone': emailOrPhone,
      'password': password,
    };
  }

  factory RegisterInitialModel.fromJson(Map<String, dynamic> json) {
    return RegisterInitialModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      emailOrPhone: json['email_or_phone'],
      password: json['password'],
    );
  }
}
