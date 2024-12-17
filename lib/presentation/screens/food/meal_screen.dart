import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/styles.dart';
import '../../../data/providers/meal_provider.dart';
import '../../widgets/homePage/mealCard.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealListAsync = ref.watch(mealListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tavsiya etilgan taomlar',
          style: CustomTextStyle.style700,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list_outlined,
              weight: 22.w,
            ),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: mealListAsync.when(
        data: (meals) => ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return MealCard(
              foodName: meal.foodName,
              waterContent: meal.waterContent,
              preparationTime: meal.preparationTime,
              foodPhoto: meal.foodPhoto,
              mealType: meal.mealType,
              calories: meal.calories,
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Xatolik yuz berdi: $err")),
      ),
    );
    // Column(
    //   children: [
    //     DateSelector(),
    //     Expanded(
    //       child: SingleChildScrollView(
    //         child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 18.0),
    //             child: Column(
    //               children: [
    //                 10.verticalSpace,
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) =>
    //                               const RecipeDetailScreen()),
    //                     );
    //                   },
    //                   child: const MealCard(
    //                       'Tushlik',
    //                       'Avokado va tuxumli buterbrod',
    //                       'assets/images/meal.png',
    //                       '20',
    //                       '1550'),
    //                 ),
    //                 24.verticalSpace,
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => RecipeDetailScreen()),
    //                     );
    //                   },
    //                   child: const MealCard(
    //                       'Tushlik',
    //                       'Avokado va tuxumli buterbrod',
    //                       'assets/images/meal.png',
    //                       '20',
    //                       '1550'),
    //                 ),
    //                 24.verticalSpace,
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => RecipeDetailScreen()),
    //                     );
    //                   },
    //                   child: const MealCard(
    //                       'Tushlik',
    //                       'Avokado va tuxumli buterbrod',
    //                       'assets/images/meal.png',
    //                       '20',
    //                       '1550'),
    //                 ),
    //                 24.verticalSpace,
    //               ],
    //             )),
    //       ),
    //     ),
    //   ],
    // ));
  }
}
