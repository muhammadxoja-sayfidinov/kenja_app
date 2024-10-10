import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';

import '../../../core/constants/colors.dart';
import '../../../data/providers/recipe_Provider.dart';
import '../../widgets/next_bottom.dart';
import '../../widgets/next_bottom_white.dart';
import 'meal_success_screen.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final meal = ref.watch(recipeProvider);

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 300.sp,
          flexibleSpace: FlexibleSpaceBar(
            title: const SizedBox(),
            background: Container(
              height: 200.sp,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/meal.png', // Your image link here
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 64.0,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (BuildContext context, int index) {
              print(meal[index].description);
              return Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      meal[index].name,
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
                              label: meal[index].preparationTime.toString(),
                              value: "Vaqt"),
                          Container(
                            color: Colors.grey,
                            width: 1,
                            height: 45.h,
                          ),
                          InfoCard(
                              label: meal[index].calories.toString(),
                              value: "Kkal"),
                          Container(
                            color: Colors.grey,
                            width: 1,
                            height: 45.h,
                          ),
                          InfoCard(
                              label: meal[index].waterConsumption.toString(),
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
                        meal[index].description,
                        style:
                            CustomTextStyle.style400.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text("Tayyorlash", style: CustomTextStyle.style600),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 400.sp,
                      width: 499,
                      child: ListView.builder(
                          itemCount: meal[index].steps.length,
                          itemBuilder: (context, int i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meal[index].steps[i].title,
                                  style: CustomTextStyle.style500,
                                ),
                                Container(
                                  width: 339.w,
                                  margin: EdgeInsets.only(left: 3.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ...meal[index]
                                          .steps[i]
                                          .instructions
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
                                                  " $instruction",
                                                  softWrap: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ); // Har bir instruktsiyani chiqaramiz
                                      }),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: 16.h),
                    isDark
                        ? MyNextBottomWhite(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MealSuccessScreen()),
                              );
                            },
                            text: 'Qabul qilish')
                        : MyNextBottom(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MealSuccessScreen()),
                              );
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
