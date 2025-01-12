import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/data/providers/providers.dart';
import 'package:kenja_app/data/providers/session_provider.dart';

import '../models/exercise_model.dart';
import '../models/workout_categories.dart';
import '../repositories/workout_categories_repository.dart';

/// WorkoutService ni `Provider` orqali taqdim etish
final workoutServiceProvider = Provider<WorkoutService>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final baseUrl = ref.watch(baseUrlProvider);
  return WorkoutService(baseUrl, secureStorage);
});

/// Kategoriyalar ro‘yxatini yuklash uchun FutureProvider
final workoutCategoriesProvider =
    FutureProvider<List<WorkoutCategory>>((ref) async {
  final service = ref.watch(workoutServiceProvider);
  return service.fetchWorkoutCategories();
});

/// Ma’lum bir `categoryId` uchun mashqlar ro‘yxatini yuklaydigan FutureProvider.family
final exercisesByCategoryProvider =
    FutureProvider.family<List<Exercise>, int>((ref, categoryId) async {
  final service = ref.watch(workoutServiceProvider);
  return service.fetchExercisesByCategory(categoryId);
});
