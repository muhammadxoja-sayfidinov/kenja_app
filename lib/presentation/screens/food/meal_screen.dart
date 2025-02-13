import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/styles.dart';
import '../../../data/providers/meal_provider.dart';
import '../../widgets/homePage/mealCard.dart';
import 'meal_detail_screen.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen({super.key, required this.sessionID});

  final int sessionID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsyncValue = ref.watch(mealsFutureProvider);

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
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: mealsAsyncValue.when(
          data: (meals) => ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailPage(
                          meal: meal,
                          sessionID: sessionID,
                        ),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.05.sp),
                  child: MealCard(
                    foodName: meal.foodName,
                    waterContent: 1,
                    preparationTime: meal.preparationTime,
                    foodPhoto: meal.foodPhoto,
                    mealType: meal.mealType,
                    calories: 1,
                  ),
                ),
              );
            },
          ),
          loading: () => const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          )),
          error: (err, stack) => Center(child: Text("Xatolik yuz berdi: $err")),
        ),
      ),
    );
  }
}
