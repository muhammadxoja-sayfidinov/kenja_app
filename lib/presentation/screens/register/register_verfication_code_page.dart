import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/screens/register/user_info_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../widgets/next_bottom.dart';

class VerificationRegisterCodePage extends ConsumerStatefulWidget {
  const VerificationRegisterCodePage({Key? key}) : super(key: key);

  @override
  ConsumerState<VerificationRegisterCodePage> createState() =>
      _VerificationRegisterCodePageState();
}

class _VerificationRegisterCodePageState
    extends ConsumerState<VerificationRegisterCodePage> {
  final _formKey = GlobalKey<FormState>();

  // Har bir xonaga alohida controller va focusNode
  final List<TextEditingController> codeController =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in codeController) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Yuqori background rasm
          Image.asset(
            'assets/images/BackgroundImage.png',
            width: double.infinity,
            height: 466.h,
            fit: BoxFit.cover,
          ),
          // Yuqorida Logo
          Align(
            heightFactor: 4.9.h,
            child: Image.asset(
              'assets/logo/logo_text.png',
              width: 201.w,
            ),
          ),
          // Quyidagi “white/dark container” qism
          Align(
            alignment: Alignment(0, 1), // Pastda joylashgan
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: isDark ? mainDarkColor : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sarlavha
                    Text(
                      'Tasdiqlash kodini kiriting',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Qaysi raqamga yuborilgani
                    Text(
                      'Biz sizga tasdiqlash kodini yubordik',
                      style: CustomTextStyle.style500.copyWith(color: grey),
                    ),
                    SizedBox(height: 16.h),

                    // KOD kirish form
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return _buildCodeField(
                            codeController[index],
                            _focusNodes[index],
                            index,
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // "Davom etish" tugmasi

                    authState.status == AuthStatus.verifying
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : MyNextBottom(
                            text: 'Verify',
                            onTap: () async {
                              final code =
                                  codeController.map((c) => c.text).join();
                              if (code.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please enter the verification code.')),
                                );
                                return;
                              }
                              await authNotifier
                                  .verifyCode(code)
                                  .whenComplete(() {});
                              if (ref.read(authProvider).status ==
                                  AuthStatus.authenticated) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserInfoScreen()),
                                  (route) => false,
                                );
                              } else if (ref.read(authProvider).errorMessage !=
                                  null) {
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
                    if (authState.loginResponse != null &&
                        authState.loginResponse!.message != 'Already logged in')
                      Text(
                        authState.loginResponse!.message!,
                        style: TextStyle(color: Colors.green),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Har bir textField xonasi
  Widget _buildCodeField(
      TextEditingController controller, FocusNode focusNode, int index) {
    return Container(
      width: 48.w,
      height: 48.w,
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
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: (value) {
          if (value.isNotEmpty && index < _focusNodes.length - 1) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
