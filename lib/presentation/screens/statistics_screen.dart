import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/presentation/screens/CustomCalendarScreen.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';
import '../widgets/homePage/achievements_section.dart';
import '../widgets/pro_plan.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? mainDarkColor : Colors.white,
        elevation: 0,
        title: const Text('Statistika', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.calendar_today_outlined, color: Colors.white),
            onPressed: () {
              // Calendar button action
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
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
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 12.h, left: 12.w),
                      width: 162.w,
                      decoration: BoxDecoration(
                        color: isDark ? backgroundDarker : darker,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: _buildStatisticCard(
                          '1500', 'Kkal', 'assets/images/arm.png')),
                  Container(
                    padding: EdgeInsets.only(top: 12.h, left: 12.w),
                    width: 162.w,
                    decoration: BoxDecoration(
                      color: isDark ? backgroundDarker : darker,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: _buildStatisticCard(
                        '16/100', 'Mashqlar', 'assets/images/leg.png'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              const ProPlan(),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScrollableCalendarScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: isDark ? backgroundDarker : darker,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Haftalik kaloriya',
                            style: CustomTextStyle.style600,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: isDark
                                  ? backgroundDarker
                                  : Color.fromRGBO(233, 234, 234, 1),
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                Text(
                                  'Iyul 12, 2024',
                                  style: CustomTextStyle.style400
                                      .copyWith(color: grey),
                                ),
                                8.horizontalSpace,
                                SvgPicture.asset('assets/icons/calendar.svg')
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 200.h,
                        width: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartBarO(
                            animate: true,
                            allowSliding: true,
                            groupList: [
                              OrdinalGroup(
                                color: statisticsGreen,
                                id: '1',
                                data: [
                                  OrdinalData(
                                    domain: '1 hafta',
                                    measure: 130,
                                  ),
                                  OrdinalData(
                                    domain: '2 hafta',
                                    measure: 409,
                                  ),
                                  OrdinalData(
                                    domain: '3 hafta',
                                    measure: 300,
                                  ),
                                  OrdinalData(
                                    domain: '4 hafta',
                                    measure: 200,
                                  ),
                                  OrdinalData(
                                    domain: 'Thu',
                                    measure: 240,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String value, String label, String iconPath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CustomTextStyle.style400,
        ),
        Text(
          value,
          style: CustomTextStyle.style600,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.r)),
            child: Image.asset(
              iconPath,
              height: 70.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
