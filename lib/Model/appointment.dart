import 'dart:convert';

import 'user.dart';

import 'disease.dart';

class Appointment {
  String title;
  String desc;
  String date;
  String startTime;
  String endTime;
  MyUser user;
  String phone;
  List<Disease> diseases;

  Appointment(
      {required this.title,
      required this.desc,
      required this.user,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.diseases,
      required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'user': user.toMap(),
      'diseases': diseases.map((x) => x.toMap()).toList(),
      'phone': phone
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
        title: map['title'] ?? '',
        desc: map['desc'] ?? '',
        date: map['date'],
        startTime: map['startTime'],
        endTime: map['endTime'],
        user: MyUser.fromMap(map['user']),
        diseases:
            List<Disease>.from(map['diseases']?.map((x) => Disease.fromMap(x))),
        phone: map["phone"] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source));
}
