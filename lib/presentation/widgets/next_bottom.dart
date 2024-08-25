import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';

class MyNextBottom extends StatelessWidget {
  const MyNextBottom(
      {super.key, required this.onTap, required this.text, this.color = white});

  final void Function() onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 339.w,
      height: 44.r,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: color == Colors.white ? Colors.white : darkColor)),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: mainDarkColor,
          ),
        ),
      ),
    );
  }
}
