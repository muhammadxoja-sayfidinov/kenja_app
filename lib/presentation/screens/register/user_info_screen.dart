import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';
import 'package:kenja_app/presentation/widgets/register/login_register_toggle.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../data/providers/profile_provider.dart';
import '../../widgets/custom_text_form_field.dart';
import 'goal_screen.dart';

class UserInfoScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  UserInfoScreen({super.key});

  int currentPage = 0;
  int gender = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileCompletionProvider);
    final profileNotifier = ref.read(profileCompletionProvider.notifier);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/Background.png',
              height: 446.h,
              width: double.infinity,
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
                    children: [
                      Text(
                        'Mashqlarni sizga moslashtirishimiz uchun, iltimos so’rovnomani to’ldiring',
                        style: CustomTextStyle.style700,
                      ),
                      24.verticalSpace,
                      LoginRegisterToggle(
                          onToggle: (int index) {
                            gender = 3;
                            profileNotifier
                                .setGender(index == 0 ? 'Male' : 'Female');
                            index == 0 ? 'Male' : 'Female';
                            index != 0 ? 'Male' : 'Female';
                          },
                          text1: 'Erkak',
                          text2: 'Ayol'),
                      24.verticalSpace,
                      CustomTextFormField(
                        labelText: 'Yoshingiz',
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          final age = int.tryParse(value!);
                          if (age != null) {
                            profileNotifier.setAge(age);
                          }
                          return null;
                        },
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Enter age' : null,
                      ),
                      24.verticalSpace,
                      CustomTextFormField(
                        labelText: 'Bo\'yingiz',
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'sm',
                            style: CustomTextStyle.style500,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        onSaved: (value) {
                          final height = double.tryParse(value!);
                          if (height != null) {
                            profileNotifier.setHeight(height);
                          }
                          return null;
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter height'
                            : null,
                      ),
                      24.verticalSpace,
                      CustomTextFormField(
                        controller: weightController,
                        labelText: 'Vazningiz',
                        // initialValue: weight,
                        keyboardType: TextInputType.number,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'kg',
                            style: CustomTextStyle.style500,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        onSaved: (value) {
                          final weight = double.tryParse(value!);
                          if (weight != null) {
                            profileNotifier.setWeight(weight);
                          }
                          return null;
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter weight'
                            : null,
                      ),
                      24.verticalSpace,
                      isDark
                          ? MyNextBottomWhite(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GoalScreen()),
                                  );
                                }
                              },
                              text: ('Davom etish'),
                            )
                          : MyNextBottom(
                              onTap: () {
                                if (gender == 5) {
                                  profileNotifier.setGender('Male');
                                }
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GoalScreen()),
                                  );
                                }
                              },
                              text: ('Davom etish'),
                            ),
                      24.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
