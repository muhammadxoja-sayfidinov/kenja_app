import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/mainHome.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
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
              controller: _passwordController,
              labelText: 'Parolingiz',
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, parolingizni kiriting';
                }
                if (value.length < 8) {
                  return 'Parol kamida 8 belgidan iborat bo\'lishi kerak';
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reset-password');
              },
              child: Text(
                'Parolni unutdingizmi?',
                style: CustomTextStyle.style500.copyWith(color: gray),
              ),
            ),
            25.verticalSpace,
            MyNextBottom(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainHome()),
                  );
                }
              },
              text: 'Kirish',
            ),
          ],
        ),
      ),
    );
  }
}
