import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/register/activity_level_screen.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';

import '../../../core/constants/colors.dart';
import '../../../data/providers/profile_provider.dart';

class GoalScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController goalController = TextEditingController();

  GoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileCompletionProvider);
    final profileNotifier = ref.read(profileCompletionProvider.notifier);
    const String goal1 = "Yog' yuqtish";
    const String goal2 = "ok";
    const String goal3 = "ozish";

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
                  GestureDetector(
                    onTap: () {
                      profileNotifier.setGoal(goal1);
                    },
                    child: Container(
                      height: 48.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: profileState.goal.toString() == goal1
                            ? isDark
                                ? Colors.transparent
                                : Colors.transparent
                            : isDark
                                ? mainDarkColor
                                : darkColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: profileState.goal.toString() == goal1
                              ? isDark
                                  ? Colors.white
                                  : grey
                              : Colors.white,
                          width:
                              profileState.goal.toString() == goal1 ? 2.0 : 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          goal1,
                          style: TextStyle(
                            color: profileState.goal.toString() == goal1
                                ? isDark
                                    ? Colors.white
                                    : darkColor
                                : grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      profileNotifier.setGoal(goal2);
                    },
                    child: Container(
                      height: 48.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: profileState.goal.toString() == goal2
                            ? isDark
                                ? Colors.transparent
                                : Colors.transparent
                            : isDark
                                ? mainDarkColor
                                : darkColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: profileState.goal.toString() == goal2
                              ? isDark
                                  ? Colors.white
                                  : grey
                              : Colors.white,
                          width:
                              profileState.goal.toString() == goal2 ? 2.0 : 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          goal2,
                          style: TextStyle(
                            color: profileState.goal.toString() == goal2
                                ? isDark
                                    ? Colors.white
                                    : darkColor
                                : grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      profileNotifier.setGoal(goal3);
                    },
                    child: Container(
                      height: 48.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: profileState.goal.toString() == goal3
                            ? isDark
                                ? Colors.transparent
                                : Colors.transparent
                            : isDark
                                ? mainDarkColor
                                : darkColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: profileState.goal.toString() == goal3
                              ? isDark
                                  ? Colors.white
                                  : grey
                              : Colors.white,
                          width:
                              profileState.goal.toString() == goal3 ? 2.0 : 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          goal3,
                          style: TextStyle(
                            color: profileState.goal.toString() == goal3
                                ? isDark
                                    ? Colors.white
                                    : darkColor
                                : grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // CustomToggleButtons(
                  //   pageIndex: profileState.,
                  // ),
                  24.verticalSpace,
                  isDark
                      ? MyNextBottomWhite(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ActivityLevelScreen(),
                              ),
                            );
                          },
                          text: 'Davom etish')
                      : MyNextBottom(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ActivityLevelScreen(),
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
