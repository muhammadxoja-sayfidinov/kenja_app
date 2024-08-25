import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/register/login_page.dart';
import 'package:kenja_app/presentation/screens/register/new_password_page.dart';
import 'package:kenja_app/presentation/screens/register/password_reset_page.dart';
import 'package:kenja_app/presentation/screens/register/tips_page.dart';
import 'package:kenja_app/presentation/screens/register/verification_code_page.dart';

import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return AdaptiveTheme(
              light: lightTheme,
              dark: darkTheme,
              initial: savedThemeMode ?? AdaptiveThemeMode.light,
              builder: (theme, darkTheme) => MaterialApp(
                    title: 'My Fitness App',
                    theme: theme,
                    darkTheme: darkTheme,
                    home: TipsScreen(),
                    routes: {
                      '/login': (context) => LoginPage(),
                      '/reset-password': (context) => PasswordResetPage(),
                      '/verification-code': (context) => VerificationCodePage(),
                      '/new-password': (context) => NewPasswordPage(),
                    },
                  ));
        });
  }
}
