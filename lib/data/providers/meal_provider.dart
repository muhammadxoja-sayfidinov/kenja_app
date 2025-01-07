import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal_model.dart';
import '../repositories/meal_repository.dart';

/// Birorta `MealsService` ni Provider orqali ta’minlash
final mealsServiceProvider = Provider<MealsService>((ref) {
  return MealsService();
});

/// FutureProvider: API’dan ma’lumotni olib keladigan provider
final mealsFutureProvider = FutureProvider<List<Meal>>((ref) async {
  final service = ref.watch(mealsServiceProvider);
  return service.fetchMeals();
});
