// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/workout_categories.dart';
// import '../repositories/workout_categories_repository.dart';
//
// // Repository provider
// final workoutCategoryRepositoryProvider =
//     Provider<WorkoutCategoryRepository>((ref) {
//   return WorkoutCategoryRepository();
// });
//
// // Workout categories ro'yxati provider
// final workoutCategoriesProvider =
//     FutureProvider<List<WorkoutCategoryModel>>((ref) async {
//   final repo = ref.watch(workoutCategoryRepositoryProvider);
//   return repo.fetchWorkoutCategories();
// });
//
// // Bitta workout category (id bo'yicha) provider
// final workoutCategoryDetailProvider =
//     FutureProvider.family<WorkoutCategoryModel, int>((ref, categoryId) async {
//   final repo = ref.watch(workoutCategoryRepositoryProvider);
//   return repo.fetchWorkoutCategoryById(categoryId);
// });
