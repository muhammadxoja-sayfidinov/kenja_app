// presentation/screens/register/registration_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';

import '../../../data/models/register.dart';
import '../../../data/providers/register_provider.dart';
import '../../screens/register/register_verfication_code_page.dart';
import '../../widgets/custom_text_form_field.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  const RegistrationForm({super.key});

  @override
  ConsumerState<RegistrationForm> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController(); // email yoki phone
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RegistrationState (status, message, userId)
    final registrationState = ref.watch(registrationNotifierProvider);
    // Qurilma mavzusi (dark/light)
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Agar ro‘yxatdan o‘tish boshlab yuborilgan bo‘lsa (loading)
    final bool isSubmitting =
        registrationState.status == RegistrationStatus.submitting;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // 1) FIRST NAME
            CustomTextFormField(
              controller: _firstNameCtrl,
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
              controller: _lastNameCtrl,
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
              controller: _phoneCtrl,
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
              controller: _passwordCtrl,
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
              controller: _confirmPasswordCtrl,
              labelText: 'Parolni takrorlang',
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, parolni takrorlang';
                }
                if (value != _passwordCtrl.text) {
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
            isDark
                ? MyNextBottom(
                    onTap: isSubmitting
                        ? () {}
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            final request = RegisterRequest(
                              firstName: _firstNameCtrl.text.trim(),
                              lastName: _lastNameCtrl.text.trim(),
                              emailOrPhone: _phoneCtrl.text.trim(),
                              password: _passwordCtrl.text,
                            );

                            await ref
                                .read(registrationNotifierProvider.notifier)
                                .registerInitial(request);

                            final currentState =
                                ref.read(registrationNotifierProvider);

                            print(
                                'Current State Status: ${currentState.status}');
                            print(
                                'Is Success: ${currentState.status == RegistrationStatus.success}');
                            print(
                                'Current State Status Type: ${currentState.status.runtimeType}');
                            print(
                                'RegistrationStatus.success Type: ${RegistrationStatus.success.runtimeType}');

                            if (currentState.status ==
                                    RegistrationStatus.success &&
                                currentState.userId != null &&
                                currentState.userId! > 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VerificationRegisterCodePage()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(currentState.message ?? 'Success!'),
                                ),
                              );
                            } else if (currentState.status ==
                                RegistrationStatus.error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(currentState.message ??
                                      'Xatolik yuz berdi'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    text: isSubmitting
                        ? 'Iltimos, kuting...' // or show a small loader
                        : 'Registratsiya qilish',
                  )
                : MyNextBottomWhite(
                    onTap: isSubmitting
                        ? () {}
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            final request = RegisterRequest(
                              firstName: _firstNameCtrl.text.trim(),
                              lastName: _lastNameCtrl.text.trim(),
                              emailOrPhone: _phoneCtrl.text.trim(),
                              password: _passwordCtrl.text,
                            );

                            await ref
                                .read(registrationNotifierProvider.notifier)
                                .registerInitial(request);

                            final currentState =
                                ref.read(registrationNotifierProvider);

                            if (currentState.status ==
                                    RegistrationStatus.success &&
                                currentState.userId != null &&
                                currentState.userId! > 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VerificationRegisterCodePage()));

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(currentState.message ?? 'Success!'),
                                ),
                              );
                            } else if (currentState.status ==
                                RegistrationStatus.error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(currentState.message ??
                                      'Xatolik yuz berdi'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    text: isSubmitting
                        ? 'Iltimos, kuting...'
                        : 'Registratsiya qilish',
                  ),

            // Agar xohlasangiz, pastda status bo‘yicha xabar chiqarish ham mumkin
            if (registrationState.status == RegistrationStatus.error &&
                registrationState.message != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  registrationState.message!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (registrationState.status == RegistrationStatus.success &&
                registrationState.message != null &&
                (registrationState.userId == null ||
                    registrationState.userId! <= 0))
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  registrationState.message!,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
