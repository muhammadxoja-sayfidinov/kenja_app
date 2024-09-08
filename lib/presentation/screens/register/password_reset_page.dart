import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';
import '../../widgets/custom_text_form_field.dart';

class PasswordResetPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();

  PasswordResetPage({super.key});

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
          Align(
              heightFactor: 4.9.h,
              // alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/logo/logo_text.png',
                width: 201.w,
              )),
          Align(
            alignment: const Alignment(0, 1),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? mainDarkColor
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parolni tiklash',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
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
                            Navigator.pushNamed(context, '/verification-code');
                          }
                        },
                        text: 'Tasdiqlash kodini olish'),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
