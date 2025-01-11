import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/register/activity_level_screen.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';

import '../../../core/constants/colors.dart';
import '../../widgets/custom_toggle_buttons.dart';

class GoalScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController goalController = TextEditingController();

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
                    'Maqsadingizni belgilang',
                    style: CustomTextStyle.style700,
                  ),
                  24.verticalSpace,
                  const CustomToggleButtons(
                    pageIndex: 0,
                  ),
                  24.verticalSpace,
                  isDark
                      ? MyNextBottomWhite(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActivityLevelScreen(),
                              ),
                            );
                          },
                          text: 'Davom etish')
                      : MyNextBottom(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActivityLevelScreen(),
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
