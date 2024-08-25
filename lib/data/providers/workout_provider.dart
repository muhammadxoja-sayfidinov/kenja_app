import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

final workoutProvider = Provider<Workout>((ref) {
  return Workout(
    title: 'Yurish mashqlari',
    description:
        'Yurish mashqi sizning umumiy sog‘ligingizni yaxshilash, quvvat va chidamlilikni oshirish uchun ajoyib usul hisoblanadi. Quyidagi qadamlarga o‘rgatib samarali yurish mashqi o‘tkazing:',
    duration: '1s 30min',
    calories: 50,
    waterIntake: '~3L',
    exercises: [
      Exercise(
        title: '1. Isinish (5-10 daqiqa)',
        description: 'Yengil yurish yoki joyida yurishni boshlang.',
        imagePath: 'assets/images/Rectangle 5817.png',
        duration: '5-10 daqiqa',
      ),
      Exercise(
        title: '2. Asosiy Mashq (2-3 daqiqa)',
        description:
            'Sekin sur\'atda yugurishni boshlang va asta-sekin tezligingizni oshiring.',
        imagePath: 'assets/images/Rectangle 5817.png',
        duration: '2-3 daqiqa',
      ),
      // Add more exercises as needed
    ],
  );
});
