import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/presentation/screens/NotificationScreen.dart';

import '../../core/constants/styles.dart';
import '../../data/providers/session_provider.dart';
import '../widgets/homePage/achievements_section.dart';
import '../widgets/homePage/exercises_section.dart';
import '../widgets/homePage/mealCard.dart';
import 'food/meal_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(combinedSessionDetailProvider);
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
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: SvgPicture.asset(
                width: 22.w,
                'assets/icons/notification-bing.svg',
                colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : mainDarkColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const AchievementsSection(),
          Expanded(
            child: asyncValue.when(
              data: (sessionDetails) {
                return ListView.builder(
                  itemCount: sessionDetails.length,
                  itemBuilder: (context, index) {
                    final detail = sessionDetails[index];
                    final session = detail.session;
                    final workouts = detail.workoutCategories; // to'liq model
                    final meals = detail.meals; // to'liq model

                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Mashqlar bo'limi
                              if (workouts.isEmpty)
                                Center(
                                  child: Text(
                                    'Mashqlar mavjud emas',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                )
                              else
                                Text(
                                  'Bugun bajaramiz 💪🏻',
                                  style: CustomTextStyle.style600,
                                ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: workouts.length,
                                itemBuilder: (context, index) {
                                  final workout = workouts[index];
                                  return ExercisesSection(
                                    category: workout,
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
                              if (meals.isEmpty)
                                Center(
                                  child: Text(
                                    'Taomlar mavjud emas',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                )
                              else
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: meals.length,
                                  itemBuilder: (context, index) {
                                    final meal = meals[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MealDetailPage(
                                                meal: meal,
                                              ),
                                            ));
                                      },
                                      child: MealCard(
                                        foodName: meal.foodName,
                                        waterContent:
                                            double.parse(meal.waterContent),
                                        preparationTime: meal.preparationTime,
                                        foodPhoto: meal.foodPhoto,
                                        mealType: meal.mealType,
                                        calories: double.parse(meal.calories),
                                      ),
                                    );
                                  },
                                ),
                            ]));
                  },
                );
              },
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              )),
              error: (err, st) => Center(child: Text('Xatolik: $err')),
            ),
          ),
        ],
      ),
    );
  }

// Widget _buildSessionDetails(WidgetRef ref, SessionModel session) {
//   return Consumer(
//     builder: (context, ref, _) {
//       final sessionDetailsAsync = ref.watch(sessionRepositoryProvider);
//
//       return sessionDetailsAsync.when(
//         data: (details) => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Mashqlar bo'limi
//             Text(
//               'Bugungi mashqlar',
//               style: TextStyle(
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             12.verticalSpace,
//             if (details.workouts.isEmpty)
//               Center(
//                 child: Text(
//                   'Mashqlar mavjud emas',
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//               )
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: details.workouts.length,
//                 itemBuilder: (context, index) {
//                   final workout = details.workouts[index];
//                   return ExercisesSection(
//                     categoryName: workout.categoryName,
//                   );
//                 },
//               ),
//
//             24.verticalSpace,
//
//             // Taomlar bo'limi
//             Text(
//               'Bugungi taomlar',
//               style: TextStyle(
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             12.verticalSpace,
//             if (details.meals.isEmpty)
//               Center(
//                 child: Text(
//                   'Taomlar mavjud emas',
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//               )
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: details.meals.length,
//                 itemBuilder: (context, index) {
//                   final meal = details.meals[index];
//                   return MealCard(
//                     foodName: meal.foodName,
//                     waterContent: meal.waterContent,
//                     preparationTime: meal.preparationTime,
//                     foodPhoto: meal.foodPhoto,
//                     mealType: meal.mealType,
//                     calories: meal.calories,
//                   );
//                 },
//               ),
//           ],
//         ),
//         loading: () => const Center(
//             child: CircularProgressIndicator(
//           color: Colors.red,
//         )),
//         error: (error, stack) => Center(
//           child: Column(
//             children: [
//               const Icon(Icons.error_outline, color: Colors.red),
//               8.verticalSpace,
//               Text('Xatolik: $error'),
//               8.verticalSpace,
//               ElevatedButton(
//                 onPressed: () {
//                   ref.refresh(sessionsProvider);
//                 },
//                 child: const Text('Qayta yuklash'),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
}
