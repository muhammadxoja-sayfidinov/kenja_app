import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/data/providers/providers.dart';
import 'package:kenja_app/data/providers/session_provider.dart';

import '../models/meal_model.dart';
import '../repositories/meal_repository.dart';

/// Birorta `MealsService` ni Provider orqali ta’minlash
final mealsServiceProvider = Provider<MealsService>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return MealsService(baseUrl, secureStorage);
});

/// FutureProvider: API’dan ma’lumotni olib keladigan provider
final mealsFutureProvider = FutureProvider<List<Meal>>((ref) async {
  final service = ref.watch(mealsServiceProvider);
  return service.fetchMeals();
});
