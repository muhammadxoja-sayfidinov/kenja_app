import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';
import '../screens/subscription/subscription_screen.dart';

class ProPlan extends StatelessWidget {
  const ProPlan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SubscriptionScreen(),
          ),
        );
      },
      child: Container(
        width: 339.w,
        height: 84.h,
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    CircleAvatar(
                        maxRadius: 12.r,
                        // backgroundColor: darkColor,
                        child: SvgPicture.asset(
                          'assets/icons/crown.svg',
                          color: isDark ? Colors.white : Colors.black,
                        )),
                    2.horizontalSpace,
                    Text('PRO PLAN',
                        style: CustomTextStyle.style700.copyWith(
                            color: isDark ? Colors.black : Colors.white)),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Barcha mashqlarni ko\'rish imkoniyat',
                  style: CustomTextStyle.style400.copyWith(
                      fontSize: 12.sp,
                      color: isDark ? Colors.black : Colors.white),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: isDark ? mainDarkColor : Colors.white,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              width: 93.w,
              height: 32.h,
              child: Text(
                'Sotib olish',
                textAlign: TextAlign.center,
                style: CustomTextStyle.style600.copyWith(
                  fontSize: 12.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
