import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/mainHome.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';
import '../../../data/providers/profile_provider.dart';
import '../../widgets/next_bottom_white.dart';

class ActivityLevelScreen extends ConsumerWidget {
  const ActivityLevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileCompletionProvider);
    final profileNotifier = ref.read(profileCompletionProvider.notifier);
    const String level1 = "Beginner";
    const String level2 = "Intermediate";
    const String level3 = "Advanced";

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
                color: isDark ? mainDarkColor : Colors.white,
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
                  GestureDetector(
                    onTap: () {
                      profileNotifier.setLevel(level1);
                    },
                    child: Container(
                      height: 48.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: profileState.level.toString() == level1
                            ? Colors.transparent
                            : isDark
                                ? mainDarkColor
                                : darkColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: profileState.level.toString() == level1
                              ? isDark
                                  ? Colors.white
                                  : grey
                              : Colors.white,
                          width: profileState.level.toString() == level1
                              ? 2.0
                              : 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          level1,
                          style: TextStyle(
                            color: profileState.level.toString() == level1
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
                      profileNotifier.setLevel(level2);
                    },
                    child: Container(
                      height: 48.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: profileState.level.toString() == level2
                            ? Colors.transparent
                            : isDark
                                ? mainDarkColor
                                : darkColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: profileState.level.toString() == level2
                              ? isDark
                                  ? Colors.white
                                  : grey
                              : Colors.white,
                          width: profileState.level.toString() == level2
                              ? 2.0
                              : 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          level2,
                          style: TextStyle(
                            color: profileState.level.toString() == level2
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
                      profileNotifier.setLevel(level3);
                    },
                    child: Container(
                      height: 48.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: profileState.level.toString() == level3
                            ? Colors.transparent
                            : isDark
                                ? mainDarkColor
                                : darkColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: profileState.level.toString() == level3
                              ? isDark
                                  ? Colors.white
                                  : grey
                              : Colors.white,
                          width: profileState.level.toString() == level3
                              ? 2.0
                              : 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          level3,
                          style: TextStyle(
                            color: profileState.level.toString() == level3
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
                  24.verticalSpace,
                  profileState.isSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : isDark
                          ? MyNextBottomWhite(
                              onTap: () async {
                                await profileNotifier.submitProfile();
                                final error =
                                    ref.read(profileCompletionProvider).error;
                                if (error == null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainHome()),
                                      (route) => false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $error')),
                                  );
                                }
                              },
                              text: 'Davom etish')
                          : MyNextBottom(
                              onTap: () async {
                                await profileNotifier.submitProfile();
                                final error =
                                    ref.read(profileCompletionProvider).error;
                                if (error == null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainHome()),
                                      (route) => false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $error')),
                                  );
                                }
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
