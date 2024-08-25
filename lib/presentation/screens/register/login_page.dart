import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/register/RegistrationForm.dart';
import '../../widgets/register/login_form.dart';
import '../../widgets/register/login_register_toggle.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 0;

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/BackgroundImage.png',
            width: double.infinity,
            height: 466.h,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: _selectedIndex == 0 ? 210.h : 60.h),
                Text(
                  'Logo',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 80.h),
                Container(
                  decoration: BoxDecoration(
                    // color: mainDarkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      24.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: LoginRegisterToggle(
                          onToggle: _onToggle,
                          text1: 'Krish',
                          text2: 'Registratsiya',
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: _selectedIndex == 0
                            ? LoginForm()
                            : const RegistrationForm(),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
