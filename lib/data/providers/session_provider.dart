import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/data/providers/providers.dart';

import '../models/meal_model.dart';
import '../models/session_model.dart';
import '../models/workout_categories.dart';
import '../repositories/session_repository.dart';

/// Asosiy bazaviy URL
final baseUrlProvider = Provider<String>((ref) {
  return 'https://owntrainer.uz/api'; // misol uchun
});

/// Session repository provayderi
final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final baseUrl = ref.watch(baseUrlProvider);
  return SessionRepository(baseUrl: baseUrl, secureStorage);
});

/// Workout Category repository provayderi
final workoutCategoryRepositoryProvider =
    Provider<WorkoutCategoryRepository>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return WorkoutCategoryRepository(baseUrl: baseUrl, secureStorage);
});

/// Meal repository provayderi
final mealRepositoryProvider = Provider<MealRepository>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return MealRepository(baseUrl: baseUrl, secureStorage);
});

/// Sessions ma'lumotini oladigan future provider
final sessionsFutureProvider = FutureProvider<List<Session>>((ref) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.fetchSessions();
});

/// Hammasini birlashtirib beradigan provider
final combinedSessionDetailProvider =
    FutureProvider.autoDispose<List<SessionDetail>>((ref) async {
  // 1) Avval session’larni olamiz
  final sessions = await ref.watch(sessionsFutureProvider.future);

  // 2) Repozitoriyalar
  final workoutRepo = ref.watch(workoutCategoryRepositoryProvider);
  final mealRepo = ref.watch(mealRepositoryProvider);

  // 3) Har bir session uchun exercises va meals’ni so‘rov qilish
  final List<SessionDetail> result = [];

  for (final session in sessions) {
    // session.exercises = [2, ...]
    final exercisesData = <WorkoutCategory>[];
    for (final exerciseId in session.exercises) {
      final exercise = await workoutRepo.fetchWorkoutCategoryById(exerciseId);
      exercisesData.add(exercise);
    }

    // session.meals = [2, ...]
    final mealsData = <Meal>[];
    for (final mealId in session.meals) {
      final meal = await mealRepo.fetchMealById(mealId);
      mealsData.add(meal);
    }

    final sessionDetail = SessionDetail(
      session: session,
      workoutCategories: exercisesData,
      meals: mealsData,
    );

    result.add(sessionDetail);
  }

  return result;
});
