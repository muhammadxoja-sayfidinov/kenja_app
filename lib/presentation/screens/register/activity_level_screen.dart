import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/mainHome.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';
import '../../widgets/custom_toggle_buttons.dart';
import '../../widgets/next_bottom_white.dart';

class ActivityLevelScreen extends ConsumerWidget {
  const ActivityLevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/BackgroundImage.png',
          width: double.infinity,
          height: 446.h,
          fit: BoxFit.cover,
        ),
        Align(
            heightFactor: 4.9.h,
            // alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/logo/logo_text.png',
              width: 201.w,
            )),
        Align(
          alignment: const Alignment(0, 1),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? mainDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Darajangizni belgilang',
                    style: CustomTextStyle.style700,
                  ),
                  24.verticalSpace,
                  const CustomToggleButtons(
                    pageIndex: 1,
                  ),
                  24.verticalSpace,
                  isDark
                      ? MyNextBottomWhite(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainHome(),
                              ),
                            );
                          },
                          text: 'Davom etish')
                      : MyNextBottom(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainHome(),
                              ),
                            );
                          },
                          text: 'Davom etish'),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
