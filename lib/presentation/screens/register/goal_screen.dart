import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/home_screen.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../widgets/custom_toggle_buttons.dart';

final goalProvider = StateProvider<String?>((ref) => null);

class GoalScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goal = ref.watch(goalProvider);

    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/BackgroundImage.png',
          width: double.infinity,
          height: 446.h,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 210.h),
              Text(
                'Logo',
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 90.h),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: 18.w,
                ),
                height: 320.h,
                decoration: BoxDecoration(
                  // color: mainDarkColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maqsadingizni belgilang',
                      style: CustomTextStyle.style700,
                    ),
                    24.verticalSpace,
                    const CustomToggleButtons(
                      pageIndex: 0,
                    ),
                    24.verticalSpace,
                    MyNextBottom(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        text: 'Davom etish')
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
