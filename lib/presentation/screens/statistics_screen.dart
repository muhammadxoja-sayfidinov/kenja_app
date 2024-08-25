import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/styles.dart';
import '../widgets/homePage/achievements_section.dart';
import '../widgets/pro_plan.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: mainDarkColor,
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
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                // height: 375.h,
                height: 102.h,
                decoration: BoxDecoration(
                  // color: darkColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const AchievementsSection(),
              ),
              SizedBox(height: 16.h),
              _buildStatisticsCards(),
              SizedBox(height: 16.h),
              const ProPlan(),
              SizedBox(height: 16.h),
              _buildWeeklyCaloriesChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatisticCard('1500', 'Kkal', 'assets/images/arm.png'),
        _buildStatisticCard('16/100', 'Mashqlar', 'assets/images/exercise.png'),
      ],
    );
  }

  Widget _buildStatisticCard(String value, String label, String iconPath) {
    return Container(
      // padding: EdgeInsets.all(16.w),
      width: 162.w,
      height: 120.h,
      decoration: BoxDecoration(
        // color: darkColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment(-0.7.w, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CustomTextStyle.style400,
                ),
                Text(
                  value,
                  style: CustomTextStyle.style600,
                ),
              ],
            ),
          ),
          Image.asset(
            iconPath,
            // width: 126.w,
            height: 70.h,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCaloriesChart() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Haftalik kaloriya',
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            'Iyul 12, 2024',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 200.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barGroups: [
                  _buildBarChartGroup(0, 1500),
                  _buildBarChartGroup(1, 800),
                  _buildBarChartGroup(2, 1200),
                  _buildBarChartGroup(3, 2000),
                ],
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Text('1 hafta',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp));
                          case 1:
                            return Text('2 hafta',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp));
                          case 2:
                            return Text('3 hafta',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp));
                          case 3:
                            return Text('4 hafta',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp));
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarChartGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          // color: statisticsGreen,
          width: 16.w,
        ),
      ],
    );
  }
}
