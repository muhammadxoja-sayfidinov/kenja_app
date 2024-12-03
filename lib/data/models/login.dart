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

// login_response.dart
class LoginResponse {
  final String message;
  final String refresh;
  final String access;

  LoginResponse({
    required this.message,
    required this.refresh,
    required this.access,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      refresh: json['refresh'] ?? '',
      access: json['access'] ?? '',
    );
  }
}
