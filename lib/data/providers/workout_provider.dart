import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/workout_categories.dart';
import '../repositories/workout_categories_repository.dart';

final workoutCategoryRepositoryProvider =
    Provider((ref) => WorkoutCategoryRepository());

final workoutCategoryListProvider =
    FutureProvider<List<WorkoutCategory>>((ref) async {
  final repository = ref.read(workoutCategoryRepositoryProvider);
  return await repository.fetchWorkoutCategories();
});
