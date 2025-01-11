// presentation/screens/register/registration_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';
import '../../../data/models/register_initial_model.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../screens/register/register_verfication_code_page.dart';
import '../../widgets/custom_text_form_field.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  const RegistrationForm({super.key});

  @override
  ConsumerState<RegistrationForm> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  // void dispose() {
  //   _firstNameCtrl.dispose();
  //   _lastNameCtrl.dispose();
  //   _phoneCtrl.dispose();
  //   _passwordCtrl.dispose();
  //   _confirmPasswordCtrl.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    final authState = ref.watch(authProvider);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // 1) FIRST NAME
            CustomTextFormField(
              controller: firstNameController,
              labelText: 'Ismingiz',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, ismingizni kiriting';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // 2) LAST NAME
            CustomTextFormField(
              controller: lastNameController,
              labelText: 'Familiyangiz',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, familiyangizni kiriting';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // 3) EMAIL or PHONE
            CustomTextFormField(
              controller: emailOrPhoneController,
              labelText: 'Email’ingiz yoki raqamingiz',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, emailingiz yoki raqamingizni kiriting';
                }
                // Agar email tekshirish yoki phone formatini tekshirish kerak bo‘lsa, shu yerda qo‘shing.
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // 4) PASSWORD
            CustomTextFormField(
              controller: passwordController,
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

            // 5) CONFIRM PASSWORD
            CustomTextFormField(
              // controller: passwordController,
              labelText: 'Parolni takrorlang',
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, parolni takrorlang';
                }
                if (value != passwordController.text) {
                  return 'Parol mos emas!';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // 6) SHARTLARGA ROZILIK (checkbox). Hozircha static
            InkWell(
              onTap: () {
                // TODO: Agar sizda "termsAcceptedProvider" bo'lsa, toggling
                // ref.read(termsAcceptedProvider.notifier).state = !ref.read(termsAcceptedProvider);
              },
              child: Row(
                children: [
                  // Check Box
                  // final isAccepted = ref.watch(termsAcceptedProvider);
                  Icon(
                    true ? Icons.check_box : Icons.check_box_outline_blank,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Dasturdan foydalanish shartlariga roziman.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // 7) REGISTRATION BUTTON
            // Agar isSubmitting bo'lsa, tugma disable yoki progress bo'lishi mumkin
            authState.status == AuthStatus.authenticating
                ? const CircularProgressIndicator(
                    color: red,
                  )
                : MyNextBottom(
                    text: authState.errorMessage != null
                        ? authState.errorMessage!
                        : 'Registratsiya qilish',
                    onTap: () async {
                      final firstName = firstNameController.text.trim();
                      final lastName = lastNameController.text.trim();
                      final emailOrPhone = emailOrPhoneController.text.trim();
                      final password = passwordController.text.trim();

                      if (firstName.isEmpty ||
                          lastName.isEmpty ||
                          emailOrPhone.isEmpty ||
                          password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields.')),
                        );
                        return;
                      }

                      final model = RegisterInitialModel(
                        firstName: firstName,
                        lastName: lastName,
                        emailOrPhone: emailOrPhone,
                        password: password,
                      );

                      await authNotifier.registerInitial(model);

                      if (ref.read(authProvider).status ==
                          AuthStatus.unauthenticated) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const VerificationRegisterCodePage()),
                        );
                      } else if (ref.read(authProvider).errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Error: ${ref.read(authProvider).errorMessage}')),
                        );
                      }
                    },
                  ),
            const SizedBox(height: 20),
            if (authState.errorMessage != null)
              Text(
                authState.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
