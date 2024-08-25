import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/profile/profile_edit_screen.dart';
import 'package:kenja_app/presentation/screens/profile/user_details_screen.dart';
import 'package:kenja_app/presentation/widgets/pro_plan.dart';

import '../../widgets/chooseLanguage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              15.verticalSpace,
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: IconButton(
                    icon: Icon(
                      AdaptiveTheme.of(context).mode.isDark
                          ? Icons.sunny
                          : Icons.dark_mode,
                    ),
                    onPressed: () {
                      AdaptiveTheme.of(context).mode.isDark
                          ? AdaptiveTheme.of(context).setLight()
                          : AdaptiveTheme.of(context).setDark();
                    },
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50.r,
                backgroundImage: const AssetImage(
                    'assets/images/avatar.png'), // Replace with actual image URL
              ),
              12.verticalSpace,
              Text('Habibxonov Hikmatullo', style: CustomTextStyle.style600),
              4.verticalSpace,
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileEditScreen()),
                  );
                },
                child: Container(
                  width: 90.w,
                  height: 29.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                        // color: darkColor,
                        ),
                    borderRadius: BorderRadius.circular(
                      80.r,
                    ),
                  ),
                  child: Text(
                    'Tahrirlash',
                    style: CustomTextStyle.style400,
                  ),
                ),
              ),
              21.verticalSpace,
              const ProPlan(),
              20.verticalSpace,
              CustomListTile(
                leading: 'assets/icons/notification-bing.svg',
                title: 'Bildirishnoma',
                subtitle: 'Eslatma 30 oldin',
                trailing: Switch(
                  value: value, // Replace with your state
                  onChanged: (val) {
                    setState(() {
                      val ? value = true : value = false;
                      print(value);
                    });
                    // Toggle notification action
                  },
                  activeColor: Colors.greenAccent,
                ),
              ),
              Divider(
                // color: darkColor,
                indent: 55.w,
                height: 0,
              ),
              CustomListTile(
                leading: 'assets/icons/calendar-edit.svg',
                title: 'Mening ma’lumotlarim',
                subtitle: 'Vazn yo’qotish',
                trailing: SvgPicture.asset(
                  'assets/icons/arrow-right.svg',
                  height: 24.w,
                  width: 24.w,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(),
                    ),
                  );
                },
              ),
              Divider(
                // color: darkColor,
                indent: 55.w,
                height: 0,
              ),
              CustomListTile(
                leading: 'assets/icons/global.svg',
                title: 'Ilova tili',
                subtitle: 'O’zbekcha',
                trailing: SvgPicture.asset(
                  'assets/icons/arrow-right.svg',
                  height: 24.w,
                  width: 24.w,
                ),
                onTap: () {
                  showLanguageSelectionSheet(context);
                },
              ),
              Divider(
                // color: darkColor,
                indent: 55.w,
                height: 0,
              ),
              CustomListTile(
                leading: 'assets/icons/info-circle.svg',
                title: 'Biz haqimizda',
                subtitle: '',
                trailing: SvgPicture.asset(
                  height: 24.w,
                  width: 24.w,
                  'assets/icons/arrow-right.svg',
                ),
              ),
              Divider(
                // color: darkColor,
                indent: 55.w,
                height: 10.h,
              ),
              CustomListTile(
                leading: 'assets/icons/shield-tick.svg',
                title: 'Maxfiylik siyosati',
                subtitle: '',
                trailing: SvgPicture.asset(
                  'assets/icons/link.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.trailing,
    required this.leading,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget trailing;
  final String leading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: Container(
            padding: const EdgeInsets.all(8),
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              // color: darkColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(
              leading,
              // color: Colors.white,
            )),
        title: Text(
          title,
          style: CustomTextStyle.style400
              .copyWith(color: Colors.white, fontSize: 16.sp),
        ),
        subtitle: subtitle != null && subtitle!.isNotEmpty
            ? Text(
                subtitle!,
                style: CustomTextStyle.style400,
              )
            : null,
        trailing: trailing);
  }
}
