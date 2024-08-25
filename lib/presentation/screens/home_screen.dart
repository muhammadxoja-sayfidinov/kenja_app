import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';

import '../../core/constants/styles.dart';
import '../widgets/homePage/achievements_section.dart';
import '../widgets/homePage/exercises_section.dart';
import '../widgets/homePage/mealCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainDarkColor,
      appBar: AppBar(
        title: Text(
          'App logo',
          style: CustomTextStyle.style700,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              weight: 22.w,
            ),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              // height: 375.h,
              height: 102.h,
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const AchievementsSection(),
            ),
            12.verticalSpace,
            Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.w),
                height: 334.w,
                decoration: BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const ExercisesSection(
                  today: true,
                  done: false,
                )),
            24.verticalSpace,
            Container(
              height: 287.w,
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: MealCard('Nonushta', 'Avokado va tuxumli buterbrod',
                    'assets/images/meal.png', '20', '1550'),
              ),
            ),
            24.verticalSpace,
            Container(
              height: 278.w,
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: MealCard('Tushlik', 'Avokado va tuxumli buterbrod',
                    'assets/images/meal.png', '20', '1550'),
              ),
            ),
            18.verticalSpace,
          ],
        ),
      ),
    );
  }
}
