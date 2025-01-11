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
  final String refresh;

  LoginResponse({
    required this.message,
    required this.access,
    required this.refresh,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      access: json['access'],
      refresh: json['refresh'],
    );
  }
}
