import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int selectedIndex = 2; // Initially selecting the third date (12th)

  final List<Map<String, String>> dates = [
    {'day': '10', 'label': 'Du'},
    {'day': '11', 'label': 'Se'},
    {'day': '12', 'label': 'Cho'},
    {'day': '13', 'label': 'Pa'},
    {'day': '14', 'label': 'Ju'},
    {'day': '15', 'label': 'Sha'},
    {'day': '16', 'label': 'Ya'},
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 58.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              width: 50.w,
              margin: EdgeInsets.symmetric(horizontal: 4.0.w),
              decoration: BoxDecoration(
                color: isDark
                    ? isSelected
                        ? Colors.white
                        : selectedIndex >= index
                            ? darkColor
                            : grey
                    : isSelected
                        ? darkColor
                        : selectedIndex >= index
                            ? grey
                            : Colors.black12,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dates[index]['day']!,
                      style: TextStyle(
                        color: isDark
                            ? isSelected
                                ? Colors.black
                                : selectedIndex >= index
                                    ? grey
                                    : Colors.white70
                            : Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dates[index]['label']!,
                      style: TextStyle(
                        color: isDark
                            ? isSelected
                                ? Colors.black
                                : selectedIndex >= index
                                    ? grey
                                    : Colors.white70
                            : Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
