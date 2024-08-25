import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/register/login_page.dart';
import 'package:kenja_app/presentation/screens/register/new_password_page.dart';
import 'package:kenja_app/presentation/screens/register/password_reset_page.dart';
import 'package:kenja_app/presentation/screens/register/tips_page.dart';
import 'package:kenja_app/presentation/screens/register/verification_code_page.dart';

import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'My Fitness App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: TipsScreen(),
            routes: {
              '/login': (context) => LoginPage(),
              '/reset-password': (context) => PasswordResetPage(),
              '/verification-code': (context) => VerificationCodePage(),
              '/new-password': (context) => NewPasswordPage(),
            },
          );
        });
  }
}
