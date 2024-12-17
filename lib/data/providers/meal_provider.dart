import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart.dart';
import '../repositories/meal_repository.dart';

final mealRepositoryProvider = Provider((ref) => MealRepository());

final mealListProvider = FutureProvider<List<Meal>>((ref) async {
  final mealRepository = ref.read(mealRepositoryProvider);
  return await mealRepository.fetchMeals();
});
