import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';
import '../../../data/providers/api_controllers.dart';
import '../../screens/register/user_info_screen.dart';
import '../custom_text_form_field.dart';

class RegistrationForm extends ConsumerWidget {
  RegistrationForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final bool _isTermsAccepted = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(usernameProvider);
    final lastName = ref.watch(lastNameControllerProvider);
    final phoneOrEmail = ref.watch(phoneOrEmailControllerProvider);
    final password = ref.watch(passwordControllerProvider);
    final confirmPassword = ref.watch(confirmPasswordControllerProvider);
    final isTermsAccepted = ref.watch(termsAcceptedProvider);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: userName,
              labelText: 'Ismingiz',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, ismingizni kiriting';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              controller: lastName,
              labelText: 'Familiyangiz',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, familiyangizni kiriting';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              controller: phoneOrEmail,
              labelText: 'Emailingiz yoki raqamingiz',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, emailingiz yoki raqamingizni kiriting';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              controller: password,
              labelText: 'Parol o\'ylab toping',
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, parol kiriting';
                }
                if (value.length < 8) {
                  return 'Parol kamida 8 belgidan iborat bo\'lishi kerak';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              controller: confirmPassword,
              labelText: 'Parolni takrorlang',
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, parolni takrorlang';
                }
                if (value != password.text) {
                  return 'Parol bir biri bilan mos emas!';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            InkWell(
              onTap: () {
                ref.read(termsAcceptedProvider.notifier).state =
                    !isTermsAccepted;
              },
              child: Row(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      // Watch for changes in the termsAcceptedProvider
                      final isAccepted = ref.watch(termsAcceptedProvider);
                      return Icon(
                        isAccepted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      );
                    },
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Text(
                      'Dasturdan foydalanish shartlariga rozilik bildiraman.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            MyNextBottom(
              color: _isTermsAccepted ? Colors.white : darkColor,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfoScreen()));
              },
              text: 'Registratsiya qilish',
            ),
          ],
        ),
      ),
    );
  }
}
