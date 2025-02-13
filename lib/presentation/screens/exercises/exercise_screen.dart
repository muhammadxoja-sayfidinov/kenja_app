import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Sizning loyihangizdagi custom widget va provayderlarni import qilish
import 'package:kenja_app/presentation/screens/exercises/workout_detail_card.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../data/models/exercise_model.dart';
import '../../../data/models/workout_categories.dart';
import '../../../data/providers/exercise_providers.dart';
import 'exercises_detail_card.dart';

class ExerciseScreen extends ConsumerStatefulWidget {
  final WorkoutCategory category;
  final int sessionId;

  const ExerciseScreen({
    Key? key,
    required this.category,
    required this.sessionId,
  }) : super(key: key);

  @override
  ConsumerState<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
  /// Hozirgi (bajarilayotgan) mashq indeksi
  int _currentExerciseIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Riverpod orqali mazkur kategoriyaga oid mashqlar ro‘yxatini olayapmiz
    final exercisesAsync =
        ref.watch(exercisesByCategoryProvider(widget.category.id));
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Yuqori qism (rasmli AppBar)
          SliverAppBar(
            expandedHeight: 150.h,
            flexibleSpace: FlexibleSpaceBar(
              title: const SizedBox(),
              background: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage(widget.category.workoutImage.toString()),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 64.0,
                  ),
                ),
              ),
            ),
          ),

          // Asosiy qism
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: exercisesAsync.when(
                    data: (exercises) {
                      // Kategoriya bo‘yicha hech qanday mashq topilmasa
                      if (exercises.isEmpty) {
                        return const Center(
                          child:
                              Text("Ushbu toifada hech qanday mashq topilmadi"),
                        );
                      }

                      // Barcha mashqlar tugagan bo‘lsa
                      if (_currentExerciseIndex >= exercises.length) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Barcha mashqlar tugadi!",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            24.verticalSpace,
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Orqaga qaytish"),
                            ),
                          ],
                        );
                      }

                      // Ekranda kategoriya ma’lumotlari, ro‘yxat, tugmalar
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kategoriya nomi
                          SizedBox(height: 8.h),
                          Text(
                            widget.category.categoryName,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),

                          // Uchta indikator: vaqt, kaloriya, suv ichish
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ExerciseDetailCard(
                                value: '1s 30min',
                                unit: 'Kkal',
                                imagePath: 'assets/images/time.png',
                                isDark: isDark,
                              ),
                              ExerciseDetailCard(
                                value: '50',
                                unit: 'Kkal',
                                imagePath: 'assets/images/calories.png',
                                isDark: isDark,
                              ),
                              ExerciseDetailCard(
                                value: '~3L',
                                unit: 'Suv ichish',
                                imagePath: 'assets/images/water.png',
                                isDark: isDark,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Kategoriya tavsifi
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: isDark ? backgroundDarker : darker,
                            ),
                            child: Text(
                              widget.category.description,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // “Mashqlar” sarlavha
                          Text(
                            'Mashqlar',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),

                          // Barcha mashqlar ro'yxati: bajarilmagan, bajarilayotgan va bajarilgan bo'lsin
                          ListView.builder(
                            shrinkWrap: true,
                            // Ta ki SingleChildScrollView/Column ichida ham ishlasin
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: exercises.length,
                            itemBuilder: (context, i) {
                              return _buildExerciseItem(
                                  context, exercises[i], i);
                            },
                          ),

                          16.verticalSpace,

                          // “Keyingi mashq” tugmasi
                          InkWell(
                            onTap: () async {
                              // Agar hozirgi mashq tugamagan bo‘lsa, tugatish
                              if (_currentExerciseIndex < exercises.length) {
                                final currentExercise =
                                    exercises[_currentExerciseIndex];

                                try {
                                  // Hozirgi mashqni yakunlash
                                  final apiService =
                                      ref.read(workoutServiceProvider);
                                  await apiService.completeExercise(
                                    widget.sessionId,
                                    currentExercise.id,
                                  );
                                  // Yakunlangach, keyingi mashqqa o‘tamiz
                                  setState(() {
                                    _currentExerciseIndex++;
                                  });
                                } catch (e) {
                                  // Xatolik bo'lsa
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: Text(
                                          'Failed to complete Exercise: $e'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              height: 44.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(12.sp),
                              decoration: BoxDecoration(
                                color: isDark ? darkColor : darker,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: isDark ? Colors.white : grey,
                                ),
                              ),
                              child: Text(
                                (_currentExerciseIndex < exercises.length - 1)
                                    ? "Keyingi mashq"
                                    : "Tugatish",
                                style: CustomTextStyle.style500,
                              ),
                            ),
                          ),

                          24.verticalSpace,
                        ],
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Center(child: Text('Xatolik yuz berdi: $error')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Har bir mashqni holatiga qarab (bajarilgan, bajarilayotgan, bajarilmagan) turli dizayn beradigan funksiya
  Widget _buildExerciseItem(
      BuildContext context, Exercise exercise, int index) {
    final isCompleted = index < _currentExerciseIndex; // Bajarilgan
    final isCurrent = index == _currentExerciseIndex; // Hozir bajarilayotgan
    final isNotStarted = index > _currentExerciseIndex; // Hali boshlanmagan

    // Mashq blokini yasaymiz
    Widget exerciseWidget = WorkoutDetailCard(
      exercise: exercise,
      isDark: Theme.of(context).brightness == Brightness.dark,
    );

    // Agar bajarilgan bo‘lsa (isCompleted) — kulrang (grey) effekt berish
    if (isCompleted) {
      exerciseWidget = ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.grey, // kulrang tus
          BlendMode.saturation,
        ),
        child: exerciseWidget,
      );
    }
    // Agar hali boshlanmagan bo‘lsa (isNotStarted) — xira yoki blur
    else if (isNotStarted) {
      // 1) Sodda: faqat xira qilib qo‘yamiz
      exerciseWidget = Opacity(
        opacity: 0.4, // xiralash darajasi
        child: exerciseWidget,
      );

      // 2) Yoki blur berish uchun:
      // exerciseWidget = Stack(
      //   children: [
      //     exerciseWidget,
      //     Positioned.fill(
      //       child: Container(
      //         color: Colors.white.withOpacity(0.2), // biroz tusi
      //       ),
      //     ),
      //   ],
      // );
    }
    // Agar hozir bajarilayotgan bo‘lsa (isCurrent) — e’tiborni tortish uchun ramka
    else if (isCurrent) {
      exerciseWidget = Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          // yoqimli ko‘k ramka
          borderRadius: BorderRadius.circular(8),
        ),
        child: exerciseWidget,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: exerciseWidget,
    );
  }
}
