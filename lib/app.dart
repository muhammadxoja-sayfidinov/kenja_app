import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/mainHome.dart';
import 'package:kenja_app/presentation/screens/register/login_page.dart';
import 'package:kenja_app/presentation/screens/register/new_password_page.dart';
import 'package:kenja_app/presentation/screens/register/password_reset_page.dart';
import 'package:kenja_app/presentation/screens/register/tips_page.dart';
import 'package:kenja_app/presentation/screens/register/verification_code_page.dart';

import 'config/theme.dart';
import 'data/providers/auth_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AdaptiveTheme(
          light: lightTheme,
          dark: darkTheme,
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) => MaterialApp(
            title: 'My Fitness App',
            theme: theme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: authState.status == AuthStatus.authenticated
                ? MainHome()
                : TipsScreen(),
            routes: {
              '/login': (context) => const LoginPage(),
              '/reset-password': (context) => PasswordResetPage(),
              '/verification-code': (context) => VerificationCodePage(),
              '/new-password': (context) => NewPasswordPage(),
            },
          ),
        );
      },
    );
  }
}
