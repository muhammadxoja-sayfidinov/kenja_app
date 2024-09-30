import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';

class RecipeNotifier extends StateNotifier<List<Recipe>> {
  RecipeNotifier()
      : super([
          Recipe(
            name: "Avokado va tuxumli buterbrod",
            preparationTime: 20,
            calories: 1650,
            waterConsumption: 3.0,
            description:
                "Avokado va tuxumda mavjud sog'lom yog'lar yurak salomatligini qo'llab-quvvatlaydi.",
            steps: [
              StepDetail(
                title: "Tuxumlarni tayyorlash",
                instructions: [
                  "Tuxumlarni suvda qaynatib yoki yumshoq qilib pishiring.",
                  "Tuz va murch bilan ziravorlang."
                ],
              ),
              StepDetail(
                title: "Avokadoni tayyorlash",
                instructions: [
                  "Avokadoni ikkiga bo'lib, toshdan ajrating.",
                  "Avokadoni vilka bilan ezib, pastaga aylantiring.",
                  "Agar xohlasangiz, tuz, murch va limon sharbatini qo'shib aralashtiring."
                ],
              ),
              StepDetail(
                title: "Nonni tayyorlash",
                instructions: [
                  "Non tilimlarini tostda yoki zaytun yog'i bilan qovurilgan holda tayyorlang."
                ],
              ),
              StepDetail(
                title: "Buterbrodni yig'ish",
                instructions: [
                  "Non tilimlariga avokado pastasini surting.",
                  "Ustiga tuxum qo'ying va qo'shimcha ziravorlar bilan bezating."
                ],
              ),
            ],
          ),
        ]);
}

final recipeProvider =
    StateNotifierProvider<RecipeNotifier, List<Recipe>>((ref) {
  return RecipeNotifier();
});
