import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../data/models/meal_model.dart';
import '../../../data/providers/meal_provider.dart';
import '../../widgets/next_bottom.dart';
import '../../widgets/next_bottom_white.dart';
import 'meal_success_screen.dart';

class MealDetailPage extends ConsumerWidget {
  final Meal meal;
  final int sessionID;

  const MealDetailPage(
      {super.key, required this.meal, required this.sessionID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200.sp,
          flexibleSpace: FlexibleSpaceBar(
            title: const SizedBox(),
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      meal.foodPhoto, // your image link here
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      meal.foodName,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isDark ? darkColor : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Rounded corners
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoCard(
                              label: meal.preparationTime.toString(),
                              value: "Vaqt"),
                          Container(
                            color: Colors.grey,
                            width: 1,
                            height: 45.h,
                          ),
                          InfoCard(
                              label: meal.calories.toString().split('.0')[0],
                              value: "Kkal"),
                          Container(
                            color: Colors.grey,
                            width: 1,
                            height: 45.h,
                          ),
                          InfoCard(
                              label:
                                  meal.waterContent.toString().split('.0')[0],
                              value: "Suv ichish"),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: isDark ? backgroundDarker : darker),
                      child: Text(
                        meal.preparationTime.toString(),
                        style:
                            CustomTextStyle.style400.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text("Tayyorlash", style: CustomTextStyle.style600),
                    SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: meal.preparations[index].steps.length,
                          itemBuilder: (context, int i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meal.preparations[index].steps[i].title,
                                  style: CustomTextStyle.style500,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ...meal.preparations[index].steps
                                        .map((instruction) {
                                      return IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Align(
                                              alignment: Alignment(0, -0.6),
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                              ),
                                            ),
                                            4.horizontalSpace,
                                            Expanded(
                                              child: Text(
                                                'instruction',
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ); // Har bir instruktsiyani chiqaramiz
                                    }),
                                  ],
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: 16.h),
                    isDark
                        ? MyNextBottomWhite(
                            onTap: () async {
                              try {
                                // API xizmatidan foydalanib, ovqatni yakunlash so'rovini yuborish
                                final apiService =
                                    ref.read(mealsServiceProvider);
                                await apiService.completeMeal(sessionID,
                                    meal.id); // session_id = 1, meal_id = 2
                                // Agar muvaffaqiyatli bo'lsa, natijani ko'rsatish
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MealSuccessScreen()),
                                );
                              } catch (e) {
                                // Xatolik yuz bersa
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Failed to complete meal: $e'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            text: 'Qabul qilish')
                        : MyNextBottom(
                            onTap: () async {
                              try {
                                // API xizmatidan foydalanib, ovqatni yakunlash so'rovini yuborish
                                final apiService =
                                    ref.read(mealsServiceProvider);
                                await apiService.completeMeal(sessionID,
                                    meal.id); // session_id = 1, meal_id = 2
                                // Agar muvaffaqiyatli bo'lsa, natijani ko'rsatish
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MealSuccessScreen()),
                                );
                              } catch (e) {
                                // Xatolik yuz bersa
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Failed to complete meal: $e'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            text: 'Qabul qilish'),
                    24.verticalSpace,
                  ],
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const InfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0.w),
      decoration: BoxDecoration(
        // color: darkColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Text(label, style: CustomTextStyle.style700),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class InstructionStep extends StatelessWidget {
  final String step;
  final String description;

  const InstructionStep({required this.step, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
