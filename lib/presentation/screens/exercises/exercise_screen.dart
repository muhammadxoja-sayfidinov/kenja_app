import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/exercises/workout_detail_card.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../data/models/workout_categories.dart';
import '../../../data/providers/exercise_providers.dart';
import 'exercise_success_screen.dart';
import 'exercises_detail_card.dart';

class ExerciseScreen extends ConsumerWidget {
  final WorkoutCategory category;

  const ExerciseScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(exercisesByCategoryProvider(category.id));

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.h,
            flexibleSpace: FlexibleSpaceBar(
              title: const SizedBox(),
              background: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(category.workoutImage.toString()),
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
                        category.categoryName,
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
                          category.description,
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
                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: exercisesAsync.when(
                          data: (exercises) {
                            return Column(
                              children: exercises
                                  .map((ex) => WorkoutDetailCard(
                                        exercise: ex,
                                        isDark: isDark,
                                      ))
                                  .toList(),
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) =>
                              Center(child: Text('Xatolik yuz berdi: $error')),
                        ),
                      ),
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
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                              color: isDark ? darkColor : darker,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  color: isDark ? Colors.white : grey)),
                          child: Text('-01:29:59',
                              style: CustomTextStyle.style500),
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
