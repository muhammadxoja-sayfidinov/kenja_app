import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';

class CustomTextStyle {
  CustomTextStyle._();

  static TextStyle style400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: gray,
  );
  static TextStyle style500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: gray,
  );
  static TextStyle style600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: white,
  );
  static TextStyle style700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
    color: white,
  );
}
