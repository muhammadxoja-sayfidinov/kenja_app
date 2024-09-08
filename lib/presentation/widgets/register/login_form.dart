import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../screens/mainHome.dart';
import '../custom_text_form_field.dart';
import '../next_bottom.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController =
        ref.watch(formStateProvider.notifier).usernameController;
    final passwordController =
        ref.watch(formStateProvider.notifier).passwordController;
    final isValid = ref.watch(formStateProvider);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            controller: usernameController,
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
            controller: passwordController,
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
              style: CustomTextStyle.style500.copyWith(color: grey),
            ),
          ),
          25.verticalSpace,
          MyNextBottom(
            color: isDark
                ? isValid
                    ? Colors.white12
                    : darkColor
                : isValid
                    ? Colors.white12
                    : darkColor,
            // Color is updated based on form state
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
    );
  }
}

class FormStateNotifier extends StateNotifier<bool> {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  FormStateNotifier(this.usernameController, this.passwordController)
      : super(false) {
    // Add listeners to both controllers
    usernameController.addListener(_validate);
    passwordController.addListener(_validate);
  }

  // Check if both fields are not empty and update the state
  void _validate() {
    state = usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    usernameController.removeListener(_validate);
    passwordController.removeListener(_validate);
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// Create a provider for form validation state
final formStateProvider = StateNotifierProvider<FormStateNotifier, bool>((ref) {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  return FormStateNotifier(usernameController, passwordController);
});
