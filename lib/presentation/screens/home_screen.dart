import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/colors.dart';

import '../../data/providers/meal_provider.dart';
import '../widgets/homePage/achievements_section.dart';
import '../widgets/homePage/exercises_section.dart';
import 'NotificationScreen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealListAsync = ref.watch(mealListProvider);

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: isDark
            ? Image.asset(
                'assets/logo/logo_text.png',
                width: 85.w,
              )
            : Image.asset(
                'assets/logo/logo_light_text.png',
                width: 85.w,
              ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SvgPicture.asset(
                width: 22.w,
                'assets/icons/notification-bing.svg',
                colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : mainDarkColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 112.h,
              decoration: BoxDecoration(
                color: isDark ? backgroundDarker : darker,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const AchievementsSection(),
            ),
            12.verticalSpace,
            Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.w),
                height: 334.w,
                decoration: BoxDecoration(
                  color: isDark ? backgroundDarker : darker,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const ExercisesSection(
                  today: true,
                  done: false,
                )),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
