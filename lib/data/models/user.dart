class User {
  int id;
  String firstName;
  String lastName;
  String emailOrPhone;
  String gender;
  String country;
  int age;
  int height;
  int weight;
  String goal;
  String level;
  bool isPremium;
  String photo;
  String language;
  DateTime dateJoined;
  bool isActive;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.emailOrPhone,
    required this.gender,
    required this.country,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.level,
    required this.isPremium,
    required this.photo,
    required this.language,
    required this.dateJoined,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailOrPhone: json["email_or_phone"],
        gender: json["gender"],
        country: json["country"],
        age: json["age"],
        height: json["height"],
        weight: json["weight"],
        goal: json["goal"],
        level: json["level"],
        isPremium: json["is_premium"],
        photo: json["photo"],
        language: json["language"],
        dateJoined: DateTime.parse(json["date_joined"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email_or_phone": emailOrPhone,
        "gender": gender,
        "country": country,
        "age": age,
        "height": height,
        "weight": weight,
        "goal": goal,
        "level": level,
        "is_premium": isPremium,
        "photo": photo,
        "language": language,
        "date_joined": dateJoined.toIso8601String(),
        "is_active": isActive,
      };
}
