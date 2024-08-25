import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../widgets/custom_text_form_field.dart';

class PasswordResetPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/BackgroundImage.png',
            width: double.infinity,
            height: 523.h,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180.h),
                Text(
                  'Logo',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 180.h),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // color: mainDarkColor,
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parolni tiklash',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                            'Parolni tiklashimiz uchun tizimdagi raqam yoki emailingizni kiriting',
                            style: CustomTextStyle.style500),
                        SizedBox(height: 24.h),
                        Form(
                          key: _formKey,
                          child: CustomTextFormField(
                            controller: _emailOrPhoneController,
                            labelText: 'Raqam yoki email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Iltimos, raqam yoki emailingizni kiriting';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 32.h),
                        MyNextBottom(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(
                                    context, '/verification-code');
                              }
                            },
                            text: 'Tasdiqlash kodini olish'),
                      ],
                    ),
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
