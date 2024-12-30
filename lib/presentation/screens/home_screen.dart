import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/colors.dart';

import '../../data/models/session.dart';
import '../../data/providers/session_provider.dart';
import '../widgets/homePage/achievements_section.dart';
import '../widgets/homePage/exercises_section.dart';
import '../widgets/homePage/mealCard.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionListAsync = ref.watch(sessionListProvider);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: isDark
            ? Image.asset('assets/logo/logo_text.png', width: 85.w)
            : Image.asset('assets/logo/logo_light_text.png', width: 85.w),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: SvgPicture.asset(
              width: 22.w,
              'assets/icons/notification-bing.svg',
              colorFilter: ColorFilter.mode(
                  isDark ? Colors.white : mainDarkColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              20.verticalSpace,
              sessionListAsync.when(
                data: (sessions) {
                  if (sessions.isEmpty) {
                    return const Center(
                      child: Text('Mashqlar va taomlar mavjud emas'),
                    );
                  }

                  // Birinchi sessiyani olamiz
                  final firstSession = sessions.first;
                  return _buildSessionDetails(ref, firstSession);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      8.verticalSpace,
                      Text("Xatolik yuz berdi: $err"),
                      8.verticalSpace,
                      ElevatedButton(
                        onPressed: () => ref.refresh(sessionListProvider),
                        child: const Text('Qayta yuklash'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionDetails(WidgetRef ref, Session session) {
    return Consumer(
      builder: (context, ref, _) {
        final sessionDetailsAsync = ref.watch(sessionDetailsProvider(session));

        return sessionDetailsAsync.when(
          data: (details) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mashqlar bo'limi
              Text(
                'Bugungi mashqlar',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              12.verticalSpace,
              if (details.workouts.isEmpty)
                Center(
                  child: Text(
                    'Mashqlar mavjud emas',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: details.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = details.workouts[index];
                    return ExercisesSection(
                      categoryName: workout.categoryName,
                    );
                  },
                ),

              24.verticalSpace,

              // Taomlar bo'limi
              Text(
                'Bugungi taomlar',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              12.verticalSpace,
              if (details.meals.isEmpty)
                Center(
                  child: Text(
                    'Taomlar mavjud emas',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: details.meals.length,
                  itemBuilder: (context, index) {
                    final meal = details.meals[index];
                    return MealCard(
                      foodName: meal.foodName,
                      waterContent: meal.waterContent,
                      preparationTime: meal.preparationTime,
                      foodPhoto: meal.foodPhoto,
                      mealType: meal.mealType,
                      calories: meal.calories,
                    );
                  },
                ),
            ],
          ),
          loading: () => const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          )),
          error: (error, stack) => Center(
            child: Column(
              children: [
                const Icon(Icons.error_outline, color: Colors.red),
                8.verticalSpace,
                Text('Xatolik: $error'),
                8.verticalSpace,
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(sessionDetailsProvider(session));
                  },
                  child: const Text('Qayta yuklash'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
