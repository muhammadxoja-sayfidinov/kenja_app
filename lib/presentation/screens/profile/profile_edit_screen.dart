import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../data/providers/profile_provider.dart';

class ProfileEditScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: mainDarkColor,
        elevation: 0,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: const AssetImage(
                      'assets/images/avatar.png', // Replace with your image URL
                    ),
                  ),
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Colors.grey[800],
                    child: Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                decoration: BoxDecoration(
                  // color: darkColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Ismingiz',
                      initialValue: profile.name,
                      onChanged: (value) {
                        ref.read(profileProvider.notifier).updateName(value);
                      },
                    ),
                    24.verticalSpace,
                    _buildTextField(
                      label: 'Email manzilingiz',
                      initialValue: profile.email,
                      onChanged: (value) {
                        ref.read(profileProvider.notifier).updateEmail(value);
                      },
                    ),
                    24.verticalSpace,
                    _buildTextField(
                      label: 'Telefon raqam',
                      initialValue: profile.phoneNumber,
                      onChanged: (value) {
                        ref
                            .read(profileProvider.notifier)
                            .updatePhoneNumber(value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.w),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: darkColor,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    CircleAvatar(
                      // backgroundColor: darkError,
                      child: SvgPicture.asset(
                        'assets/icons/trash.svg',
                        width: 20.w,
                      ),
                    ),
                    2.horizontalSpace,
                    Text(
                      'Profilni o’chirish',
                      style:
                          CustomTextStyle.style500.copyWith(color: Colors.red),
                    ),
                  ],
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
        ),
      ),
    );
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
