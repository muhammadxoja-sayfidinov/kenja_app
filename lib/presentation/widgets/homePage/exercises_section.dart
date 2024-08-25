import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../screens/Exercises/exercise_screen.dart';
import '../next_bottom.dart';

class ExercisesSection extends StatelessWidget {
  const ExercisesSection({super.key, required this.today, required this.done});

  final bool today;
  final bool done;

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey[850],
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
                            child: const Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.ac_unit_rounded,
                                  weight: 16,
                                ),
                                Text(
                                  'Bajarilmagan',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yurish mashqlari',
                          style: CustomTextStyle.style700,
                        ),
                        16.verticalSpace,
                        MyNextBottom(
                            color: done ? Colors.transparent : white,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorkoutScreen()));
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
