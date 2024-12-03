import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../data/providers/api_controllers.dart';
import '../../../data/providers/authentication_provider.dart';
import '../../screens/mainHome.dart';
import '../custom_text_form_field.dart';
import '../next_bottom.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final isValid = ref.watch(formStateProvider);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // authState o'zgarishini kuzatish
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHome()),
        );
      } else if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage ?? 'Xatolik yuz berdi'),
          ),
        );
      }
    });

    return Form(
      key: _formKey,
      child: authState.status == AuthStatus.authenticating
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextFormField(
                  controller: _usernameController,
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
                SizedBox(height: 25.h),
                // Xatolik xabarini ko'rsatish
                if (authState.status == AuthStatus.error)
                  Text(
                    authState.errorMessage ?? 'Xatolik yuz berdi',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 10.h),
                isDark
                    ? MyNextBottomWhite(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await authNotifier.login(
                              _usernameController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        text: 'Kirish',
                      )
                    : MyNextBottom(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await authNotifier.login(
                              _usernameController.text,
                              _passwordController.text,
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
