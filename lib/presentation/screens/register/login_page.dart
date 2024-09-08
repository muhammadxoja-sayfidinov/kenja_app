import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../widgets/register/RegistrationForm.dart';
import '../../widgets/register/login_form.dart';
import '../../widgets/register/login_register_toggle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
          Align(
              heightFactor: 4.9.h,
              // alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/logo/logo_text.png',
                width: 201.w,
              )),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: _selectedIndex == 0 ? 250.h : 69.h),
                SizedBox(height: 80.h),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? mainDarkColor
                        : Colors.white,
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
                            : RegistrationForm(),
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
