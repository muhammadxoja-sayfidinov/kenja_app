import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/styles.dart';

class MealCard extends StatelessWidget {
  const MealCard(this.mealType, this.mealName, this.imagePath, this.duration,
      this.calories,
      {super.key});

  final String mealType;
  final String mealName;
  final String imagePath;
  final String duration;
  final String calories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mealType,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Container(
            // padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 5),
            width: double.infinity,
            height: 200.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0.r),
              image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealName,
                    style: CustomTextStyle.style700,
                  ),
                  12.verticalSpace,
                  Container(
                    width: 307.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(
                        16.r,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('$duration ', style: CustomTextStyle.style600),
                            5.horizontalSpace,
                            Text(
                              'min',
                              style: CustomTextStyle.style500,
                            )
                          ],
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('$calories', style: CustomTextStyle.style600),
                            5.horizontalSpace,
                            Text(
                              'Kkall',
                              style: CustomTextStyle.style500,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
