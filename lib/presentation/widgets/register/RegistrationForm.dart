import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import '../../screens/register/user_info_screen.dart';
import '../custom_text_form_field.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm();

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
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
              controller: _passwordController,
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
              controller: _confirmPasswordController,
              labelText: 'Parolni takrorlang',
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, parolni takrorlang';
                }
                if (value != _passwordController.text) {
                  return 'Parol bir biri bilan mos emas!';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      _isTermsAccepted = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'Dasturdan foydalanish shartlariga rozilik bildiraman.',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            MyNextBottom(
              onTap: _isTermsAccepted
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInfoScreen()));
                      }
                    }
                  : () {},
              text: 'Registratsiya qilish',
            ),
          ],
        ),
      ),
    );
  }
}
