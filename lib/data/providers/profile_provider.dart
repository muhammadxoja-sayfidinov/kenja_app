// lib/providers/profile_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/data/providers/providers.dart';

import '../models/auth/profile_completion_model.dart';
import '../repositories/user_repository.dart';

// ProfileCompletionState Class
class ProfileCompletionState {
  final String? gender;
  final int? age;
  final double? height;
  final double? weight;
  final String? goal;
  final String? level;
  final bool isSubmitting;
  final String? error;

  ProfileCompletionState({
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.goal,
    this.level,
    this.isSubmitting = false,
    this.error,
  });

  ProfileCompletionState copyWith({
    String? gender,
    int? age,
    double? height,
    double? weight,
    String? goal,
    String? level,
    bool? isSubmitting,
    String? error,
  }) {
    return ProfileCompletionState(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
      level: level ?? this.level,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
    );
  }
}

// ProfileCompletionNotifier Class
class ProfileCompletionNotifier extends StateNotifier<ProfileCompletionState> {
  final UserRepository _userRepository;

  ProfileCompletionNotifier(this._userRepository)
      : super(ProfileCompletionState());

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }

  void setHeight(double height) {
    state = state.copyWith(height: height);
  }

  void setWeight(double weight) {
    state = state.copyWith(weight: weight);
  }

  void setGoal(String goal) {
    state = state.copyWith(goal: goal);
  }

  void setLevel(String level) {
    state = state.copyWith(level: level);
  }

  /// Profilni to'ldirish
  Future<void> submitProfile() async {
    try {
      state = state.copyWith(isSubmitting: true, error: null);

      final profile = ProfileCompletionModel(
        gender: state.gender,
        age: state.age,
        height: state.height,
        weight: state.weight,
        goal: state.goal,
        level: state.level,
      );
      await _userRepository.completeProfile(profile);
      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      state = state.copyWith(
          isSubmitting: false, error: 'Profilni to\'ldirishda xatolik: $e');
    }
  }
}

// ProfileCompletionProvider
final profileCompletionProvider =
    StateNotifierProvider<ProfileCompletionNotifier, ProfileCompletionState>(
        (ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return ProfileCompletionNotifier(userRepository);
});
