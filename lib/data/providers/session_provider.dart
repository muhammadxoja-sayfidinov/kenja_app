// lib/providers/session_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/data/models/workout_categories.dart';

import '../models/meal.dart.dart';
import '../models/session.dart';
import '../repositories/session_repository.dart';

final sessionRepositoryProvider = Provider((ref) => SessionRepository());

// Sessions provider
final sessionListProvider = FutureProvider<List<Session>>((ref) async {
  final repository = ref.read(sessionRepositoryProvider);
  return await repository.fetchSessions();
});

// Workout provider by ID
final workoutByIdProvider =
    FutureProvider.family<WorkoutCategory, int>((ref, id) async {
  final repository = ref.read(sessionRepositoryProvider);
  return await repository.fetchWorkoutById(id);
});

// Meal provider by ID
final mealByIdProvider = FutureProvider.family<Meal, int>((ref, id) async {
  final repository = ref.read(sessionRepositoryProvider);
  return await repository.fetchMealById(id);
});

// Combined session data provider
final sessionDetailsProvider =
    FutureProvider.family<SessionDetails, Session>((ref, session) async {
  final repository = ref.read(sessionRepositoryProvider);

  try {
    // Har bir ID uchun alohida try-catch
    final workouts = await Future.wait(session.exercises.map((id) async {
      try {
        return await repository.fetchWorkoutById(id);
      } catch (e) {
        print('Error fetching workout $id: $e');
        return WorkoutCategory(
            id: id,
            categoryName: 'Not available',
            description: 'Failed to load');
      }
    }));

    final meals = await Future.wait(session.meals.map((id) async {
      try {
        return await repository.fetchMealById(id);
      } catch (e) {
        print('Error fetching meal $id: $e');
        return Meal(
          id: id,
          mealType: 'Not available',
          foodName: 'Failed to load',
          calories: 0,
          waterContent: 0,
          preparationTime: 0,
          foodPhoto: '',
        );
      }
    }));

    return SessionDetails(
      session: session,
      workouts: workouts,
      meals: meals,
    );
  } catch (e) {
    print('Error in sessionDetailsProvider: $e');
    throw e;
  }
});

// Data class to hold all session related data
class SessionDetails {
  final Session session;
  final List<WorkoutCategory> workouts;
  final List<Meal> meals;

  SessionDetails({
    required this.session,
    required this.workouts,
    required this.meals,
  });
}
