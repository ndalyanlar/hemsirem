import 'dart:convert';

class MyUser {
  String name;
  String surName;
  String password;
  String phone;
  int age;
  MyUser(
      {required this.name,
      required this.surName,
      required this.phone,
      required this.password,
      required this.age});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surName': surName,
      'password': password,
      'phone': phone,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      age: map["age"] ?? 0,
      name: map['name'] ?? '',
      surName: map['surName'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));
}
