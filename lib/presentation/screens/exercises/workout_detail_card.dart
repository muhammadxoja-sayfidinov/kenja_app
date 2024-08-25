import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/product_model.dart';

class WorkoutDetailCard extends StatelessWidget {
  final Exercise exercise;

  const WorkoutDetailCard({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: Image.asset(
            exercise.imagePath,
            width: 50.w,
            height: 50.h,
            fit: BoxFit.cover,
          ),
          title: Text(
            exercise.title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            exercise.description,
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            exercise.duration,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
