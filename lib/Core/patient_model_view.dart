import 'package:flutter/material.dart';
import 'package:hemsirem/Constant/firestore_constant.dart';
import 'package:hemsirem/Model/appointment.dart';

import '../Model/disease.dart';
import '../Model/user.dart';

class PatientModelView extends ChangeNotifier {
  late Appointment _appointment;

  List<Disease> disaseList = [
    Disease("Aşı"),
    Disease("Sağlık kontrol"),
    Disease("İğne"),
    Disease("Serum"),
  ];

  final TextEditingController _controllertitle = TextEditingController();

  void addProgress(Appointment appointment) {
    _appointment = appointment;
    notifyListeners();
  }

  List<MyUser> nurseNames = [];
  String? nurseName;

  Future<List<dynamic>> getNurseNamesFromFirebase() async {
    var data = await FirebaseDocName().getUser(type: "nurses");
    return data;
  }

  void setNurseName(value) {
    nurseName = value;
    notifyListeners();
  }
}
