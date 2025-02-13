// login_request.dart
class LoginRequest {
  String username;
  String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

// lib/data/models/login.dart

class LoginResponse {
  final String message;
  final String access;
  final String? refresh; // Nullable qilindi

  LoginResponse({
    required this.message,
    required this.access,
    this.refresh,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      access: json['access'],
      refresh: json['refresh'], // Null qabul qilishi uchun
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'access': access,
      if (refresh != null) 'refresh': refresh!,
    };
  }
}
