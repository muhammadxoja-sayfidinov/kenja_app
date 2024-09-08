import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';

import '../../../data/models/product_model.dart';

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
            Image.asset(
              exercise.imagePath,
              width: 94.w,
              height: 94.w,
              fit: BoxFit.cover,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${exercise.title} ${exercise.duration}',
                    style: CustomTextStyle.style500,
                  ),
                  Text(
                    exercise.description,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
