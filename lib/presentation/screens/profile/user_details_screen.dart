import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/presentation/widgets/custom_text_form_field.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../data/providers/user_provider.dart';
import '../../widgets/custom_toggle_buttons.dart';
import '../../widgets/edit_bottom_sheet.dart';

class UserDetailsScreen extends ConsumerWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? backgroundDarker : darker,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        title: const Text(
          'Mening ma\'lumotlarim',
        ),
      ),
      body: ListView(
        children: [
          _buildListTile(
            context: context,
            title: 'Jinsingiz',
            subtitle: userProfile.gender,
            onTap: () => _showGenderBottomSheet(context, ref),
          ),
          _buildListTile(
            context: context,
            title: 'Yoshingiz',
            subtitle: '${userProfile.age}',
            onTap: () => _showAgeBottomSheet(context, ref),
          ),
          _buildListTile(
            context: context,
            title: 'Bo\'yingiz',
            subtitle: '${userProfile.height} sm',
            onTap: () => _showHeightBottomSheet(context, ref),
          ),
          _buildListTile(
            context: context,
            title: 'Og\'irligingiz',
            subtitle: '${userProfile.weight} kg',
            onTap: () => _showWeightBottomSheet(context, ref),
          ),
          _buildListTile(
            context: context,
            title: 'Maqsadingiz',
            subtitle: userProfile.goal,
            onTap: () => _showGoalBottomSheet(context, ref),
          ),
          _buildListTile(
            context: context,
            title: 'Darajangiz',
            subtitle: userProfile.level,
            onTap: () => _showLevelBottomSheet(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 14.sp)),
      trailing: Icon(
        Icons.chevron_right,
      ),
      onTap: onTap,
    );
  }

  void _showGenderBottomSheet(BuildContext context, WidgetRef ref) {
    showEditBottomSheet(
      context: context,
      title: 'Jinsingiz',
      children: [
        _buildGenderTile(
          context,
          ref,
          title: 'Erkak',
          icon: 'assets/icons/male_icon.png', // Erkak ikonkasining manzili
          value: 'Erkak',
        ),
        Divider(
          // color: darkColor,
          indent: 65.w,
          endIndent: 40..w,
        ), // Ikki gender orasidagi chiziq
        _buildGenderTile(
          context,
          ref,
          title: 'Ayol',
          icon: 'assets/icons/female_icon.png', // Ayol ikonkasining manzili
          value: 'Ayol',
        ),
      ],
    );
  }

  Widget _buildGenderTile(BuildContext context, WidgetRef ref,
      {required String title, required String icon, required String value}) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(
          8.w,
        ),
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          // color: darkColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Image.asset(
          icon,
          fit: BoxFit.cover,
          width: 20.w,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
      trailing: Radio<String>(
        value: value,
        groupValue: ref.read(userProfileProvider).gender,
        onChanged: (newValue) {
          ref.read(userProfileProvider.notifier).updateGender(newValue!);
          Navigator.pop(context);
        },
        activeColor: Colors.white,
      ),
      onTap: () {
        ref.read(userProfileProvider.notifier).updateGender(value);
        Navigator.pop(context);
      },
    );
  }

  void _showAgeBottomSheet(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController(
        text: ref.read(userProfileProvider).age.toString());
    showEditBottomSheet(
      context: context,
      title: 'Yoshingiz',
      children: [
        CustomTextFormField(
          labelText: '',
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        MyNextBottom(
          onTap: () {
            int age = int.tryParse(controller.text) ??
                ref.read(userProfileProvider).age;
            ref.read(userProfileProvider.notifier).updateAge(age);
            Navigator.pop(context);
          },
          text: 'Saqlash',
        ),
      ],
    );
  }

  void _showHeightBottomSheet(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController(
        text: ref.read(userProfileProvider).height.toString());
    showEditBottomSheet(
      context: context,
      title: 'Bo’yingiz',
      children: [
        CustomTextFormField(
          labelText: '',
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        MyNextBottom(
          onTap: () {
            int height = int.tryParse(controller.text) ??
                ref.read(userProfileProvider).height;
            ref.read(userProfileProvider.notifier).updateHeight(height);
            Navigator.pop(context);
          },
          text: 'Saqlash',
        ),
      ],
    );
  }

  void _showWeightBottomSheet(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController(
        text: ref.read(userProfileProvider).weight.toString());
    showEditBottomSheet(
      context: context,
      title: 'Og’irligingiz',
      children: [
        CustomTextFormField(
          labelText: '',
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        MyNextBottom(
          onTap: () {
            int weight = int.tryParse(controller.text) ??
                ref.read(userProfileProvider).weight;
            ref.read(userProfileProvider.notifier).updateWeight(weight);
            Navigator.pop(context);
          },
          text: 'Saqlash',
        ),
      ],
    );
  }

  void _showGoalBottomSheet(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController(
        text: ref.read(userProfileProvider).goal.toString());
    showEditBottomSheet(
      context: context,
      title: 'Maqsadingiz',
      children: [
        const CustomToggleButtons(
          pageIndex: 0,
        ),
        24.verticalSpace,
        MyNextBottom(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Saqlash',
        ),
      ],
    );
  }

  void _showLevelBottomSheet(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController(
        text: ref.read(userProfileProvider).level.toString());
    showEditBottomSheet(
      context: context,
      title: 'Yoshingiz',
      children: [
        const CustomToggleButtons(
          pageIndex: 1,
        ),
        24.verticalSpace,
        MyNextBottom(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Saqlash',
        ),
      ],
    );
  }

// Similar functions for height, weight, goal, and level would be added here...
}
