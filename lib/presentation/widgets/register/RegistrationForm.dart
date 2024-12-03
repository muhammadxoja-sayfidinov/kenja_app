import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/register/register_verfication_code_page.dart';

import '../../../data/models/register.dart';
import '../../../data/providers/api_controllers.dart';
import '../custom_text_form_field.dart';

class RegistrationForm extends ConsumerWidget {
  RegistrationForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(usernameProvider);
    final lastName = ref.watch(lastNameControllerProvider);
    final phoneOrEmail = ref.watch(phoneOrEmailControllerProvider);
    final password = ref.watch(passwordControllerProvider);
    final confirmPassword = ref.watch(confirmPasswordControllerProvider);
    final isTermsAccepted = ref.watch(termsAcceptedProvider);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    void _submitForm() async {
      if (_formKey.currentState!.validate()) {
        if (!isTermsAccepted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Shartlarga rozilik bildirish kerak!')),
          );
          return;
        }

        final registerRequest = RegisterRequest(
          firstName: userName.text,
          lastName: lastName.text,
          emailOrPhone: phoneOrEmail.text,
          password: password.text,
          gender: "Male",
          // To‘g‘ri qiymatni sozlash (UIda gender tanlash qo‘shilishi kerak)
          country: "Uzbekistan",
          // UIda mamlakat tanlash qo‘shilishi mumkin
          age: 25,
          // Yoshingizni qo‘lda kiritish o‘rniga UI qo‘shilishi kerak
          height: 180,
          // UIga kiritish maydonini qo‘shing
          weight: 75,
          // UIga kiritish maydonini qo‘shing
          level: "Beginner",
          // UIda daraja tanlash uchun dropdown qo‘shing
          goal: "Vazn yo'qotish", // UI orqali maqsad tanlash
        );

        try {
          await ref.read(authProvider.notifier).register(registerRequest);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const VerificationRegisterCodePage()),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xatolik yuz berdi: $e')),
          );
        }
      }
    }

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
              labelText: 'Email’ingiz yoki raqamingiz',
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
            isDark
                ? ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Registratsiya qilish'),
                  )
                : ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Registratsiya qilish'),
                  ),
          ],
        ),
      ),
    );
  }
}
