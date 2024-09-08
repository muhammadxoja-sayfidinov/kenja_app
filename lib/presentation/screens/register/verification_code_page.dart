import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';

class VerificationCodePage extends StatefulWidget {
  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

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
                      'Tasdiqlash kodini kiriting',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                        'Biz +99890 *** 6263 raqamiga tasdiqlash kodini yubordik',
                        style: CustomTextStyle.style500.copyWith(color: grey)),
                    SizedBox(height: 16.h),
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (index) {
                          return _buildCodeField(
                              _controllers[index], _focusNodes[index], index);
                        }),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    MyNextBottom(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/new-password');
                        }
                      },
                      text: 'Davom etish',
                    ),
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

  Widget _buildCodeField(
      TextEditingController controller, FocusNode focusNode, int index) {
    return Container(
      alignment: Alignment.center,
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: CustomTextStyle.style700,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        // Use text instead of number for 'w'
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0, // Set consistent border width
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0, // Set consistent border width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0, // Set consistent border width
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0, // Ensure the same width as focusedBorder
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0, // Ensure the same width as focusedBorder
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ''; // Return null instead of a string to avoid error text
          }
          return null;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < _focusNodes.length - 1) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
