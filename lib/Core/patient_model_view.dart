import 'package:flutter/material.dart';
import '../Constant/firestore_constant.dart';
import '../Model/appointment.dart';

import '../Model/disease.dart';
import '../Model/user.dart';

class PatientModelView extends ChangeNotifier {
  List<Disease> disaseList = [
    Disease("Aşı"),
    Disease("Sağlık kontrol"),
    Disease("İğne"),
    Disease("Serum"),
  ];
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();
  final TextEditingController controllerStartTime = TextEditingController();
  final TextEditingController controllerendTime = TextEditingController();
  final TextEditingController controllerDesc = TextEditingController();

  void addProgress(Appointment appointment) {
    notifyListeners();
  }

  late MyUser nurse;

  void addNurseUser(MyUser? value) {
    nurse = value!;
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
