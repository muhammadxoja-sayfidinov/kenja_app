import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/core/constants/styles.dart';

class MySkipBottom extends StatelessWidget {
  const MySkipBottom({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 339.w,
      height: 44.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.transparent,
          border: Border.all(
              color: Theme.of(context).brightness == Brightness.light
                  ? gray
                  : mainDarkColor)),
      child: TextButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text('O\'tkazib yuborish',
            style: CustomTextStyle.style400.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? gray
                    : mainDarkColor)),
      ),
    );
  }
}
