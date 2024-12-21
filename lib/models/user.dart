// models/user.dart
class User {
  String name;
  String gender;
  int age;

  User({required this.name, required this.gender, required this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
    );
  }
}
