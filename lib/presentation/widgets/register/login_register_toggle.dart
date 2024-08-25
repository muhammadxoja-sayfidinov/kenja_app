import 'package:flutter/material.dart';

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
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12.0),
      ),
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
          height: 50,
          decoration: BoxDecoration(
            color: _selectedIndex == index ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
