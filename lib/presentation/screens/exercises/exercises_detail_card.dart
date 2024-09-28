import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';

class ExerciseDetailCard extends StatelessWidget {
  const ExerciseDetailCard(
      {super.key,
      required this.value,
      required this.unit,
      required this.imagePath,
      required this.isDark});

  final String value;
  final String unit;
  final String imagePath;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 60.h,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isDark ? darkColor : darker,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
