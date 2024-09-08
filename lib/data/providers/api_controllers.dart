// Login form variables
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TextEditingController for username
final usernameProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

// TextEditingController for password
final passwordProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

// Registration form controllers
final firstNameControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final lastNameControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final phoneOrEmailControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final confirmPasswordControllerProvider =
    Provider<TextEditingController>((ref) {
  return TextEditingController();
});

// Terms and conditions acceptance (this can remain as a boolean flag)
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
