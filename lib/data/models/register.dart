// models/register.dart

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String emailOrPhone;
  final String password;

  RegisterRequest({
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
}

class RegisterResponse {
  final int userId;
  final String message;

  RegisterResponse({
    required this.userId,
    required this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    // Agar server 'user_id' yoki 'id' bilan qaytarsa, uni olish
    return RegisterResponse(
      userId: json['user_id'] ?? json['id'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RegisterResponse(userId: $userId, message: $message)';
  }
}

class VerifyCodeResponse {
  final String message;

  VerifyCodeResponse({required this.message});

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponse(
      message: json['message'] ?? '',
    );
  }
}
