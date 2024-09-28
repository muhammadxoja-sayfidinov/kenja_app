import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/Exercises/workout_detail_card.dart';
import 'package:kenja_app/presentation/screens/exercises/exercise_success_screen.dart';

import '../../../data/providers/workout_provider.dart';
import 'exercises_detail_card.dart';

class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final workout = ref.watch(workoutProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 339.h,
            flexibleSpace: FlexibleSpaceBar(
              title: SizedBox(),
              background: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Rectangle 5817.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 64.0,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),

                      Text(
                        workout.title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExerciseDetailCard(
                            value: '1s 30min',
                            unit: 'Kkal',
                            imagePath: 'assets/images/time.png',
                            isDark: isDark,
                          ),
                          ExerciseDetailCard(
                            value: '50',
                            unit: 'Kkal',
                            imagePath: 'assets/images/calories.png',
                            isDark: isDark,
                          ),
                          ExerciseDetailCard(
                            value: '~3L',
                            unit: 'Suv ichish',
                            imagePath: 'assets/images/water.png',
                            isDark: isDark,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: isDark ? backgroundDarker : darker),
                        child: Text(
                          workout.description,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Mashqlar',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...workout.exercises.map((exercise) => WorkoutDetailCard(
                            exercise: exercise,
                            isDark: isDark,
                          )),
                      SizedBox(height: 16.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessScreen()),
                          );
                        },
                        child: Container(
                          height: 44.h,
                          alignment: Alignment.center,
                          padding:  EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: isDark ? darkColor : darker,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: isDark?Colors.white:grey)
                          ),
                          child: Text(
                            '-01:29:59',
                            style: CustomTextStyle.style500
                          ),
                        ),
                      ),
                      24.verticalSpace,
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
