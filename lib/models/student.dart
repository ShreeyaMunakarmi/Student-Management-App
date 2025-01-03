import 'dart:convert';

class Student {
  final String name;
  final int age;
  final String course;

  Student({required this.name, required this.age, required this.course});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      age: json['age'],
      course: json['course'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'course': course,
    };
  }
}
