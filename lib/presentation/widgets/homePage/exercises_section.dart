import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';

import '../../../core/constants/styles.dart';
import '../../screens/Exercises/exercise_screen.dart';

class ExercisesSection extends StatelessWidget {
  const ExercisesSection({super.key, required this.today, required this.done});

  final bool today;
  final bool done;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        today
            ? Text(
                'Bugun bajaramiz 💪🏻',
                style: CustomTextStyle.style600,
              )
            : const SizedBox(),
        16.verticalSpace,
        Container(
            width: double.infinity,
            height: 250.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/Rectangle 5817.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    done
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(5),
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: lightRed,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/crown.svg',
                                  colorFilter: ColorFilter.mode(
                                      isDark ? Colors.white : mainDarkColor,
                                      BlendMode.srcIn),
                                ),
                                Text(
                                  'Bajarilmagan',
                                  style: CustomTextStyle.style600.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yurish mashqlari',
                          style:
                              CustomTextStyle.style700.copyWith(color: white),
                        ),
                        16.verticalSpace,
                        MyNextBottomWhite(
                            color: done ? Colors.transparent : white,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WorkoutScreen()));
                            },
                            text: done ? 'Bajarildi' : 'Bajarish'),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
