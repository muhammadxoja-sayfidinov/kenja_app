// lib/providers/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/constants.dart';
import '../models/auth/profile_completion_model.dart';
import '../models/auth/register_initial_model.dart';
import '../models/user_profile.dart';
import '../repositories/user_repository.dart';

// FlutterSecureStorage provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// UserRepository provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return UserRepository(
    baseUrl: Constants.baseUrl,
    secureStorage: storage,
  );
});

// RegisterNotifier va Provider
class RegisterState {
  final bool isLoading;
  final int? userId;
  final String? error;

  RegisterState({this.isLoading = false, this.userId, this.error});
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final UserRepository _userRepository;

  RegisterNotifier(this._userRepository) : super(RegisterState());

  Future<void> register(RegisterInitialModel model) async {
    state = RegisterState(isLoading: true);
    try {
      final userId = await _userRepository.registerInitial(model);
      state = RegisterState(userId: userId);
    } catch (e) {
      state = RegisterState(error: e.toString());
    }
  }
}

final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return RegisterNotifier(repository);
});

// VerifyCodeNotifier va Provider
class VerifyCodeState {
  final bool isLoading;
  final String? accessToken;
  final String? message;
  final String? error;

  VerifyCodeState(
      {this.isLoading = false, this.accessToken, this.message, this.error});
}

class VerifyCodeNotifier extends StateNotifier<VerifyCodeState> {
  final UserRepository _userRepository;
  final Ref ref;

  VerifyCodeNotifier(this._userRepository, this.ref) : super(VerifyCodeState());

  Future<void> verifyCode(int userId, String code) async {
    print('`object1`');
    state = VerifyCodeState(isLoading: true);
    try {
      final response = await _userRepository.verifyCode(userId, code);
      state = VerifyCodeState(
          accessToken: response.accessToken, message: response.message);
      // Access tokenni saqlash
      await ref
          .read(secureStorageProvider)
          .write(key: Constants.accessTokenKey, value: response.accessToken);
    } catch (e) {
      state = VerifyCodeState(error: e.toString());
    }
  }
}

final verifyCodeNotifierProvider =
    StateNotifierProvider<VerifyCodeNotifier, VerifyCodeState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return VerifyCodeNotifier(repository, ref);
});

// ProfileCompletionNotifier va Provider
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
      error: error,
    );
  }
}

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

  Future<void> submitProfile() async {
    state = state.copyWith(isSubmitting: true, error: null);
    try {
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
      state = state.copyWith(isSubmitting: false, error: e.toString());
    }
  }
}

final profileCompletionNotifierProvider =
    StateNotifierProvider<ProfileCompletionNotifier, ProfileCompletionState>(
        (ref) {
  final repository = ref.watch(userRepositoryProvider);
  return ProfileCompletionNotifier(repository);
});

// UserProfileProvider
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUserProfile();
});
