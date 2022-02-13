import 'package:flutter/material.dart';
import 'package:hemsirem/Model/appointment.dart';

class NurseModelView extends ChangeNotifier {
  late Appointment _appointment;

  void addProgress(Appointment appointment) {
    _appointment = appointment;
    notifyListeners();
  }
}
