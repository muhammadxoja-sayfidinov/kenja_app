import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/styles.dart';

class MyNextBottom extends StatelessWidget {
  const MyNextBottom(
      {super.key,
      required this.onTap,
      required this.text,
      this.color = Colors.white});

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
              // color: color == Colors.white ? Colors.white : darkColor
              )),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: CustomTextStyle.style600
        ),
      ),
    );
  }
}
