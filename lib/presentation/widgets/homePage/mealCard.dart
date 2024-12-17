import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/colors.dart';

import '../../../core/constants/styles.dart';

class MealCard extends StatelessWidget {
  const MealCard(
      {super.key,
      required this.foodName,
      required this.waterContent,
      required this.preparationTime,
      required this.foodPhoto,
      required this.mealType,
      required this.calories});

  final String mealType;
  final String foodName;
  final double calories;
  final double waterContent;
  final int preparationTime;
  final String foodPhoto;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mealType,
                style: CustomTextStyle.style700,
              ),
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/refresh.svg'))
            ],
          ),
          12.verticalSpace,
          Container(
              // padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 5),
              width: double.infinity,
              height: 200.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16.0.r),
                image: DecorationImage(
                  image: NetworkImage(
                    foodPhoto,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      foodName,
                      style: CustomTextStyle.style700,
                    ),
                    12.verticalSpace,
                    Container(
                      width: 307.w,
                      height: 40.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black54 : Colors.white70,
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
                              Text(preparationTime.toString(),
                                  style: CustomTextStyle.style600),
                              5.horizontalSpace,
                              Text(
                                'Min',
                                style: CustomTextStyle.style500
                                    .copyWith(color: grey),
                              )
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(calories.toString(),
                                  style: CustomTextStyle.style600),
                              5.horizontalSpace,
                              Text(
                                'Kkall',
                                style: CustomTextStyle.style500
                                    .copyWith(color: grey),
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
      ),
    );
  }
}
