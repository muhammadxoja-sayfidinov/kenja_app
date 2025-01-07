// class Meals {
//   final int id;
//   final String mealType;
//   final String foodName;
//   final double calories;
//   final double waterContent;
//   final int preparationTime;
//   final String foodPhoto;
//
//   Meals({
//     required this.id,
//     required this.mealType,
//     required this.foodName,
//     required this.calories,
//     required this.waterContent,
//     required this.preparationTime,
//     required this.foodPhoto,
//   });
//
//   factory Meals.fromJson(Map<String, dynamic> json) {
//     // detail API uchun 'meal' key bo'lsa uni olamiz, bo'lmasa butun jsonni
//     final data = json.containsKey('meal') ? json['meal'] : json;
//
//     return Meals(
//       id: data['id'],
//       mealType: data['meal_type'],
//       foodName: data['food_name'],
//       calories: double.parse(data['calories'].toString()),
//       waterContent: double.parse(data['water_content'].toString()),
//       preparationTime: data['preparation_time'],
//       foodPhoto: data['food_photo'],
//     );
//   }
//
//   // List uchun helper method
//   static List<Meals> fromJsonList(Map<String, dynamic> json) {
//     final list = json['meals'] as List;
//     return list.map((item) => Meals.fromJson(item)).toList();
//   }
// }
