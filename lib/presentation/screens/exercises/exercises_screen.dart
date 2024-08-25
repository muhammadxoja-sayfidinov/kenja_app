import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/home_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../widgets/homePage/exercises_section.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainDarkColor,
      appBar: AppBar(
        title: Text(
          'Sizga mos mashqlar',
          style: CustomTextStyle.style700,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list_outlined,
              weight: 22.w,
            ),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 12.verticalSpace,
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    ExercisesSection(
                      done: true,
                      today: false,
                    ),
                    ExercisesSection(
                      done: false,
                      today: false,
                    ),
                    ExercisesSection(
                      done: false,
                      today: false,
                    ),
                  ],
                )),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
