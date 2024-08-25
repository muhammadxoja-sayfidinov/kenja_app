import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier()
      : super(UserProfile(
          gender: 'Erkak',
          age: 26,
          height: 175,
          weight: 60,
          goal: 'Vazn yo\'qotish',
          level: 'Boshlang\'ich',
        ));

  void updateGender(String gender) {
    state = UserProfile(
      gender: gender,
      age: state.age,
      height: state.height,
      weight: state.weight,
      goal: state.goal,
      level: state.level,
    );
  }

  void updateAge(int age) {
    state = UserProfile(
      gender: state.gender,
      age: age,
      height: state.height,
      weight: state.weight,
      goal: state.goal,
      level: state.level,
    );
  }

  void updateHeight(int height) {
    state = UserProfile(
      gender: state.gender,
      age: state.age,
      height: height,
      weight: state.weight,
      goal: state.goal,
      level: state.level,
    );
  }

  void updateWeight(int weight) {
    state = UserProfile(
      gender: state.gender,
      age: state.age,
      height: state.height,
      weight: weight,
      goal: state.goal,
      level: state.level,
    );
  }

  void updateGoal(String goal) {
    state = UserProfile(
      gender: state.gender,
      age: state.age,
      height: state.height,
      weight: state.weight,
      goal: goal,
      level: state.level,
    );
  }

  void updateLevel(String level) {
    state = UserProfile(
      gender: state.gender,
      age: state.age,
      height: state.height,
      weight: state.weight,
      goal: state.goal,
      level: level,
    );
  }
}
