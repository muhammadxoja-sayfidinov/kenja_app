import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/homePage/mealCard.dart';

import '../../../core/constants/styles.dart';
import '../../widgets/date_selector.dart';
import 'meal_detail_screen.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            DateSelector(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        10.verticalSpace,
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RecipeDetailScreen()),
                            );
                          },
                          child: const MealCard(
                              'Tushlik',
                              'Avokado va tuxumli buterbrod',
                              'assets/images/meal.png',
                              '20',
                              '1550'),
                        ),
                        24.verticalSpace,
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen()),
                            );
                          },
                          child: const MealCard(
                              'Tushlik',
                              'Avokado va tuxumli buterbrod',
                              'assets/images/meal.png',
                              '20',
                              '1550'),
                        ),
                        24.verticalSpace,
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen()),
                            );
                          },
                          child: const MealCard(
                              'Tushlik',
                              'Avokado va tuxumli buterbrod',
                              'assets/images/meal.png',
                              '20',
                              '1550'),
                        ),
                        24.verticalSpace,
                      ],
                    )),
              ),
            ),
          ],
        ));
  }
}
