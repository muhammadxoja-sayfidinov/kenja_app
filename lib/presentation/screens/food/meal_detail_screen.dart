import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import 'meal_success_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/images/meal.png', // Your image link here
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 40.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                "Avokado va tuxumli buterbrot",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(label: "20 Min", value: "Vaqt"),
                  InfoCard(label: "1650", value: "Kkal"),
                  InfoCard(label: "3L", value: "Suv ichish"),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                "Avokado va tuxumda mavjud sog'lom yog'lar (masalan, to'yinmagan yog'lar) xolesterin darajasini nazorat qilishga yordam beradi, bu yurak salomatligini qo'llab-quvvatlaydi.",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                "Tayyorlash",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              const InstructionStep(
                step: "Tuxumlarni tayyorlash:",
                description:
                    "Tuxumlarni suvda qaynatib yoki yumshoq qilib pishiring.\nTuz va murch bilan ziravorlang.",
              ),
              const InstructionStep(
                step: "Avokadoni tayyorlash: (2-3 daqiqa)",
                description:
                    "Avokadoni ikkiga bo'ling, toshdan ajrating, ichki qismini qoshiq bilan ajrating.\nAvokadoni vilkalar bilan ezib, pastaga aylantiring.",
              ),
              const InstructionStep(
                step: "Nonni tayyorlash: (2-3 daqiqa)",
                description:
                    "To'liq bug'doy noni tilimlarini tosterda yoki grilda qovuring.\nQovurilgan non ustiga zaytun yog'i surting.",
              ),
              const InstructionStep(
                step: "Buterbrotni yig'ish: (2-3 daqiqa)",
                description:
                    "Non tilimlariga avokado pastasini surting, ustiga tuxumni qo'ying.\nQo'shimcha ziravorlar bilan bezatishingiz mumkin.",
              ),
              SizedBox(height: 16.h),
              MyNextBottom(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MealSuccessScreen()),
                    );
                  },
                  text: 'Qabul qilish')
            ],
          ),
        ),
      ),
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
