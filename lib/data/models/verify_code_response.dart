// models/verify_code_response.dart
class VerifyCodeResponse {
  final String message;
  final String accessToken;

  VerifyCodeResponse({
    required this.message,
    required this.accessToken,
  });

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponse(
      message: json['message'],
      accessToken: json['access_token'],
    );
  }
}
