import 'dart:convert';

class User {
  String name;
  String surName;
  String password;
  String phone;
  User(
      {required this.name,
      required this.surName,
      required this.phone,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surName': surName,
      'password': password,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      surName: map['surName'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
