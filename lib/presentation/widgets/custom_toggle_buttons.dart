import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';

class CustomToggleButtons extends StatefulWidget {
  final int pageIndex;

  const CustomToggleButtons({super.key, required this.pageIndex});

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.pageIndex == 0
          ? [
              _buildToggleButton('Vazn yo\'qotish', 0),
              SizedBox(height: 16.h),
              _buildToggleButton('Vazn yig\'ish', 1),
              SizedBox(height: 16.h),
              _buildToggleButton('Muskul chiqarish', 2),
            ]
          : [
              SizedBox(height: 16.h),
              _buildToggleButton('Boshlag’ich', 3),
              SizedBox(height: 16.h),
              _buildToggleButton('O’rta', 4),
              SizedBox(height: 16.h),
              _buildToggleButton('Profissonal', 5),
            ],
    );
  }

  Widget _buildToggleButton(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 48.w,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? Colors.white : gray,
            width: 1.0,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : gray,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
