import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/register/login_page.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import '../../../core/constants/colors.dart';
import '../../widgets/custom_text_form_field.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/BackgroundImage.png',
            width: double.infinity,
            height: 466.h,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            reverse: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 130.h),
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
                  color: mainDarkColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 24.0.h, horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yangi parol o’rnatish',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Sizning profilingiz xavfsizligi uchun yangi parol o’rnatishimiz zarur',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: _passwordController,
                                labelText: 'Yangi parol',
                                obscureText: true,
                                suffixIcon: const Icon(
                                  Icons.visibility_off,
                                ),
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
                                labelText: 'Parolni takrorlash',
                                obscureText: true,
                                suffixIcon: Icon(Icons.visibility_off),
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
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),
                        MyNextBottom(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            }
                          },
                          text: 'Saqlash',
                        ),
                        10.verticalSpace
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
