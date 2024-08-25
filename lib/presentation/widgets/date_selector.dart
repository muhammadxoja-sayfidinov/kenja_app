import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                // color: isSelected
                //     ? Colors.white
                //     : selectedIndex >= index
                //         ? darkColor
                //         : gray,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dates[index]['day']!,
                      style: TextStyle(
                        // color: isSelected
                        //     ? Colors.black
                        //     : selectedIndex >= index
                        //         ? gray
                        //         : Colors.white70,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dates[index]['label']!,
                      style: TextStyle(
                        // color: isSelected
                        //     ? Colors.black
                        //     : selectedIndex >= index
                        //         ? gray
                        //         : Colors.white70,
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
