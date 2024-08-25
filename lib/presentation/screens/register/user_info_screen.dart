import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/presentation/widgets/register/login_register_toggle.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import '../../../core/constants/styles.dart';
import '../../state_management/product_provider.dart';
import '../../state_management/tips_provider.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/register/tips_carousel.dart';
import 'goal_screen.dart';

class UserInfoScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  UserInfoScreen({super.key});

  int currentPage = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController1 = ref.watch(tipsPageControllerProvider);

    final gender = ref.watch(genderProvider);
    final age = ref.watch(ageProvider);
    final height = ref.watch(heightProvider);
    final weight = ref.watch(weightProvider);

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
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 240.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 18.w,
                    ),
                    height: 507.h,
                    decoration: BoxDecoration(
                      color: mainDarkColor,
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
                              ref.read(genderProvider.notifier).state =
                                  index == 0 ? 'Erkak' : 'Ayol';
                              index == 0 ? 'Erkak' : 'Ayol';
                            },
                            text1: 'Erkak',
                            text2: 'Ayol'),
                        24.verticalSpace,
                        CustomTextFormField(
                          labelText: 'Yoshingiz',
                          initialValue: age,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Iltimos, yoshingizni kiriting';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              ref.read(ageProvider.notifier).state = value,
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          labelText: 'Bo\'yingiz',
                          initialValue: height,
                          keyboardType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'sm',
                              style: CustomTextStyle.style500,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          onSaved: (value) =>
                              ref.read(heightProvider.notifier).state = value,
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          labelText: 'Vazningiz',
                          initialValue: weight,
                          keyboardType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'kg',
                              style: CustomTextStyle.style500,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          onSaved: (value) =>
                              ref.read(weightProvider.notifier).state = value,
                        ),
                        24.verticalSpace,
                        MyNextBottom(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GoalScreen()),
                              );
                            }
                          },
                          text: ('Davom etish'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
