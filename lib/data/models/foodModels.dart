class Food {
  int? id;
  String? name;
  int? preparationTime;
  int? calories;
  int? waterIntake;
  String? description;
  String? ingredients;
  String? instructions;
  String? img;
  bool? isEaten;

  Food(
      {this.id,
      this.name,
      this.preparationTime,
      this.calories,
      this.waterIntake,
      this.description,
      this.ingredients,
      this.instructions,
      this.img,
      this.isEaten});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    preparationTime = json['preparation_time'];
    calories = json['calories'];
    waterIntake = json['water_intake'];
    description = json['description'];
    ingredients = json['ingredients'];
    instructions = json['instructions'];
    img = json['img'];
    isEaten = json['is_eaten'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['preparation_time'] = this.preparationTime;
    data['calories'] = this.calories;
    data['water_intake'] = this.waterIntake;
    data['description'] = this.description;
    data['ingredients'] = this.ingredients;
    data['instructions'] = this.instructions;
    data['img'] = this.img;
    data['is_eaten'] = this.isEaten;
    return data;
  }
}
