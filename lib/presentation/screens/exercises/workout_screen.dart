import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/styles.dart';
import '../../../data/providers/exercise_providers.dart';
import '../../widgets/homePage/exercises_section.dart';

class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(workoutCategoriesProvider);

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
      body: categoriesAsync.when(
        data: (categories) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ExercisesSection(
                category: category,
                sessionId: 0,
              );
            },
          );
        },
        loading: () => const Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        )),
        error: (error, stack) =>
            Center(child: Text('Xatolik yuz berdi: $error')),
      ),
    );
  }
}
