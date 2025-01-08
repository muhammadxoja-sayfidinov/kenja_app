// providers/register_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/register.dart';
import '../repositories/registration_repository.dart';

enum RegistrationStatus {
  initial,
  submitting,
  codeVerifying,
  success,
  error,
}

class RegistrationState {
  final RegistrationStatus status;
  final int? userId; // serverdan qaytgan user_id
  final String? message; // ijobiy yoki xato xabar

  RegistrationState({
    required this.status,
    this.userId,
    this.message,
  });

  RegistrationState copyWith({
    RegistrationStatus? status,
    int? userId,
    String? message,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      message: message ?? this.message,
    );
  }
}

class RegistrationNotifier extends StateNotifier<RegistrationState> {
  final RegistrationRepository repository;

  RegistrationNotifier(this.repository)
      : super(RegistrationState(status: RegistrationStatus.initial));

  /// Ro'yxatdan o'tish (initial)
  Future<void> registerInitial(RegisterRequest request) async {
    try {
      state =
          state.copyWith(status: RegistrationStatus.submitting, message: null);

      final result = await repository.registerInitial(request);
      print('registerInitial result: $result');

      // Muvaffaqiyatli bo'lsa, userId ni saqlaymiz:
      state = state.copyWith(
        status: RegistrationStatus.success,
        userId: result.userId > 0 ? result.userId : state.userId,
        message: result.message,
      );
    } catch (e) {
      // Xatolik
      state = state.copyWith(
        status: RegistrationStatus.error,
        message: e.toString(),
      );
    }
  }

  /// Tasdiqlash kodi yuborish
  Future<void> verifyCode(String code) async {
    print('Future<void> verifyCode(String code) async {');
    if (state.userId == null || state.userId == 0) {
      print('xato: userId yo‘q yoki 0');
      // userId bo'lmasa, verify code chaqira olmaysiz
      state = state.copyWith(
        status: RegistrationStatus.error,
        message: 'userId yo‘q, avval register qiling',
      );
      return;
    }

    try {
      state = state.copyWith(
          status: RegistrationStatus.codeVerifying, message: null);

      final verifyResult = await repository.verifyCode(state.userId!, code);
      print('verifyCode result: $verifyResult');

      // Muvaffaqiyatli bo‘lsa:
      state = state.copyWith(
        status: RegistrationStatus.success,
        message: verifyResult.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: RegistrationStatus.error,
        message: e.toString(),
      );
    }
  }
}

// Provider setup
final baseUrlProvider = Provider<String>((ref) {
  return 'https://owntrainer.uz/api'; // misol
});

// Repozitoriy provider
final registrationRepositoryProvider = Provider<RegistrationRepository>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  return RegistrationRepository(baseUrl: baseUrl);
});

// StateNotifier provider
final registrationNotifierProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationState>((ref) {
  final repo = ref.watch(registrationRepositoryProvider);
  return RegistrationNotifier(repo);
});
