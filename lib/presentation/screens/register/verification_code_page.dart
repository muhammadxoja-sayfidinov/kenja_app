import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

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
                    padding: EdgeInsets.all(24.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tasdiqlash kodini kiriting',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                            'Biz +99890 *** 6263 raqamiga tasdiqlash kodini yubordik',
                            style: CustomTextStyle.style500),
                        SizedBox(height: 16.h),
                        Form(
                          key: _formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(5, (index) {
                              return _buildCodeField(_controllers[index],
                                  _focusNodes[index], index);
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeField(
      TextEditingController controller, FocusNode focusNode, int index) {
    return Container(
      width: 48.w,
      height: 48.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: CustomTextStyle.style700,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '!';
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
