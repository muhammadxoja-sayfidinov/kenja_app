import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/styles.dart';
import '../../../data/providers/workout_provider.dart';
import '../../widgets/homePage/exercises_section.dart';

class ExercisesScreen extends ConsumerWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryListAsync = ref.watch(workoutCategoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sizga mos mashqlar',
          style: CustomTextStyle.style700,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list_outlined,
              weight: 22.w,
            ),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: categoryListAsync.when(
        data: (categories) => ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ExercisesSection(
              categoryName: category.categoryName,
            );
          },
        ),
        loading: () => const Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        )),
        error: (err, stack) => Center(child: Text("Xatolik yuz berdi: $err")),
      ),
    );

    //   SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // 12.verticalSpace,
    //         const Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 18.0),
    //             child: Column(
    //               children: [
    //                 ExercisesSection(
    //                   done: true,
    //                   today: false,
    //                 ),
    //                 ExercisesSection(
    //                   done: false,
    //                   today: false,
    //                 ),
    //                 ExercisesSection(
    //                   done: false,
    //                   today: false,
    //                 ),
    //               ],
    //             )),
    //         24.verticalSpace,
    //       ],
    //     ),
    //   ),
    // );
  }
}
