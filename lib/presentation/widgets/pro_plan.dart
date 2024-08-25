import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/styles.dart';
import '../screens/subscription_screen.dart';

class ProPlan extends StatelessWidget {
  const ProPlan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                          color: Colors.white,
                        )),
                    2.horizontalSpace,
                    Text('PRO PLAN',
                        style: CustomTextStyle.style700
                            .copyWith(color: Colors.black)),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Barcha mashqlarni ko\'rish imkoniyat',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              decoration: BoxDecoration(
                // color: mainDarkColor,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              width: 93.w,
              height: 32.h,
              child: Text(
                'Sotib olish',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
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
