import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../core/constants/colors.dart';

void showLanguageSelectionSheet(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    backgroundColor: isDark ? mainDarkColor : Colors.white,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
          left: 16.w,
          right: 16.w,
          top: 16.h,
        ),
        child: LanguageSelectionSheet(),
      );
    },
  );
}

class LanguageSelectionSheet extends ConsumerStatefulWidget {
  const LanguageSelectionSheet({super.key});

  @override
  ConsumerState<LanguageSelectionSheet> createState() =>
      _LanguageSelectionSheetSate();
}

class _LanguageSelectionSheetSate
    extends ConsumerState<LanguageSelectionSheet> {
  String? selectedLanguage = 'O\'zbekcha';

  final List<Map<String, String>> languages = [
    {'name': 'O\'zbekcha', 'flag': 'assets/flags/uzbekistan.png'},
    {'name': 'Русский', 'flag': 'assets/flags/russia.png'},
    {'name': 'English', 'flag': 'assets/flags/uk.png'},
    {'name': 'Portugal', 'flag': 'assets/flags/portugal.png'},
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ilova tili', style: CustomTextStyle.style600),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                    color: isDark ? darkColor : darker,
                    borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.all(8.w),
                child: Image.asset(
                  languages[index]['flag']!,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                languages[index]['name']!,
                style: CustomTextStyle.style400.copyWith(fontSize: 16.sp),
              ),
              trailing: Transform.scale(
                scale: 1.0.w,
                child: Radio<String>(
                  value: languages[index]['name']!,
                  groupValue: selectedLanguage,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ),
              onTap: () {
                setState(() {
                  selectedLanguage = languages[index]['name']!;
                });
              },
            );
          },
        ),
        Center(
          child: MyNextBottom(
              onTap: () {
                Navigator.pop(context, selectedLanguage);
              },
              text: 'Saqlash'),
        ),
        SizedBox(height: 25.h),
      ],
    );
  }
}
