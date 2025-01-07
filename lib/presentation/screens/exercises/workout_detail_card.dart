import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';

import '../../../data/models/exercise_model.dart';

class WorkoutDetailCard extends StatelessWidget {
  final Exercise exercise;
  final bool isDark;

  const WorkoutDetailCard(
      {super.key, required this.exercise, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.only(left: 13.w),
                width: 94.w,
                height: 94.h,
                decoration: const BoxDecoration(
                  color: Colors.white, // Placeholder background color
                ),
                child: Image.asset(
                  alignment: Alignment.center,
                  'assets/images/exercise.png',
                  width: 94.w,
                  height: 94.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${exercise.name} (${exercise.exerciseTime})',
                    style: CustomTextStyle.style500,
                  ),
                  Text(
                    exercise.description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
