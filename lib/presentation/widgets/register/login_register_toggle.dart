import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';

class LoginRegisterToggle extends StatefulWidget {
  final Function(int) onToggle;
  final String text1;
  final String text2;

  LoginRegisterToggle(
      {required this.onToggle, required this.text1, required this.text2});

  @override
  _LoginRegisterToggleState createState() => _LoginRegisterToggleState();
}

class _LoginRegisterToggleState extends State<LoginRegisterToggle> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? darkColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildToggleButton(widget.text1, 0),
          _buildToggleButton(widget.text2, 1),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            widget.onToggle(index);
          });
        },
        child: Container(
          height: 45.w,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? _selectedIndex == index
                    ? Colors.white
                    : darkColor
                : _selectedIndex == index
                    ? mainDarkColor
                    : Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? _selectedIndex == index
                        ? mainDarkColor
                        : grey
                    : _selectedIndex == index
                        ? Colors.white
                        : grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
