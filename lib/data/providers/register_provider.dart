// lib/providers/registration_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/data/providers/providers.dart';

import '../models/auth/register_initial_model.dart';
import '../repositories/user_repository.dart';

// RegistrationStatus Enum
enum RegistrationStatus {
  initial,
  submitting,
  success,
  error,
}

// RegistrationState Class
class RegistrationState {
  final RegistrationStatus status;
  final int? userId;
  final String? message;

  RegistrationState({
    this.status = RegistrationStatus.initial,
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

// RegistrationNotifier Class
class RegistrationNotifier extends StateNotifier<RegistrationState> {
  final UserRepository _userRepository;

  RegistrationNotifier(this._userRepository) : super(RegistrationState());

  /// Ro'yxatdan o'tish (initial)
  Future<void> registerInitial(RegisterInitialModel model) async {
    try {
      state =
          state.copyWith(status: RegistrationStatus.submitting, message: null);
      final userId = await _userRepository.registerInitial(model);
      state = state.copyWith(
        status: RegistrationStatus.success,
        userId: userId,
        message:
            'Registratsiya muvaffaqiyatli bajarildi. Tasdiqlash kodini kiriting.',
      );
    } catch (e) {
      state = state.copyWith(
        status: RegistrationStatus.error,
        message: 'Registratsiya xatolik: $e',
      );
    }
  }
}

// RegistrationProvider
final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return RegistrationNotifier(userRepository);
});
