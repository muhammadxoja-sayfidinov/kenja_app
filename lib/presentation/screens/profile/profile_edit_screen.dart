import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/custom_text_form_field.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/providers.dart';

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    final profil = ref.watch(userProfileProvider);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: isDark ? darkColor : darker,
          centerTitle: false,
          elevation: 0,
          title: Text('Profile', style: CustomTextStyle.style600),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              16.w,
            ),
            child: profil.when(
              data: (profile) => Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: profile.photo != null
                            ? NetworkImage(
                                "https://owntrainer.uz//${profile.photo}")
                            : const AssetImage(
                                'assets/images/avatar.jpeg', // Replace with your image URL
                              ),
                      ),
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.grey[800],
                        child:
                            const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.sp),
                    decoration: BoxDecoration(
                      color: isDark ? darkColor : darker,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        // Biror tugma orqali refresh tokenni trigger qilish
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     final refreshSuccess =
                        //         await authNotifier.refreshToken();
                        //     if (refreshSuccess) {
                        //       print('Token yangilandi');
                        //     } else {
                        //       print('Token yangilanmadi');
                        //     }
                        //   },
                        //   child: Text('Refresh Token'),
                        // ),

                        CustomTextFormField(
                          labelText: 'Ismingiz',
                          initialValue: profile.firstName,
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          labelText: 'Email manzilingiz',
                          initialValue: profile.emailOrPhone,
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          labelText: 'Telefon raqam',
                          initialValue: profile.emailOrPhone,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  InkWell(
                    onTap: () async {
                      await authNotifier.logout();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.w),
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: isDark ? darkColor : darker,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: isDark ? darkError : lightError,
                            child: SvgPicture.asset(
                              'assets/icons/trash.svg',
                              width: 20.w,
                            ),
                          ),
                          2.horizontalSpace,
                          Text(
                            'Profilni o’chirish',
                            style: CustomTextStyle.style500
                                .copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  MyNextBottom(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profil saqlandi!')),
                        );
                        Navigator.of(context).pop();
                      },
                      text: 'Saqlash')
                ],
              ),
              error: (err, stack) {
                debugPrint("Xatolik: $err");
                debugPrint("Stack trace: $stack");
                return Center(child: Text("Xatolik yuz berdi: $err"));
              },
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              )),
            ),
          ),
        ));
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
