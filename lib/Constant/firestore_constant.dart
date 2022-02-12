import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/user.dart';

class FirebaseDocName {
  String _patientDocId = "patients";
  String _nurseDocId = "nurses";

  Future<void> addUser(
      {required String type,
      required User user,
      required String phoneNumber}) async {
    await FirebaseFirestore.instance
        .collection(type)
        .withConverter<User>(
          fromFirestore: (snapshots, _) =>
              User.fromJson(jsonEncode(snapshots.data())),
          toFirestore: (user, _) => jsonDecode(user.toJson()),
        )
        .doc(phoneNumber)
        .set(user);
  }

  Future<DocumentSnapshot> getUser(
      {required String type, required String phoneNumber}) async {
    return await FirebaseFirestore.instance
        .collection(type)
        .withConverter<User>(
          fromFirestore: (snapshots, _) =>
              User.fromJson(jsonEncode(snapshots.data())),
          toFirestore: (user, _) => jsonDecode(user.toJson()),
        )
        .doc(phoneNumber)
        .get();
  }

  String get patientDocID => _patientDocId;
  String get nurseDocID => _nurseDocId;
}
