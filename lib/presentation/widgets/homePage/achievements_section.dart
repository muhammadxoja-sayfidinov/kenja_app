import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/colors.dart';

import '../../../core/constants/styles.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Yutuqlar',
              style: CustomTextStyle.style700,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Batafsil',
                  style: CustomTextStyle.style500.copyWith(
                    color: gray,
                  ),
                ))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 54.w,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(right: 12.w),
                        width: 56.w,
                        height: 54.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SvgPicture.asset(
                            'assets/icons/shield-tick.svg',
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
        16.verticalSpace
      ],
    );
  }
}
