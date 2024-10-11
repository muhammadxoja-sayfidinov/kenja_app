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
  String message;
  String access;
  String refresh;
  String sessionId;

  LoginResponse({
    required this.message,
    required this.access,
    required this.refresh,
    required this.sessionId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      access: json['access'],
      refresh: json['refresh'],
      sessionId: json['session_id'],
    );
  }
}
