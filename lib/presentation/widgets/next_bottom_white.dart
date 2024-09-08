import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';

class MyNextBottomWhite extends StatelessWidget {
  const MyNextBottomWhite(
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white)),
      child: TextButton(
        onPressed: onTap,
        child: Text(text,
            style: CustomTextStyle.style500
                .copyWith(fontSize: 16.sp, color: darkColor)),
      ),
    );
  }
}
