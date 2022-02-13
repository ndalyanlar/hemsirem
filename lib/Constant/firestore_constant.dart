import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/user.dart';

class FirebaseDocName {
  String _patientDocId = "patients";
  String _nurseDocId = "nurses";

  Future<void> addUser(
      {required String type,
      required MyUser user,
      required String phoneNumber}) async {
    await FirebaseFirestore.instance
        .collection(type)
        .withConverter<MyUser>(
          fromFirestore: (snapshots, _) =>
              MyUser.fromJson(jsonEncode(snapshots.data())),
          toFirestore: (user, _) => jsonDecode(user.toJson()),
        )
        .doc(phoneNumber)
        .set(user);
  }

  Future<DocumentSnapshot> getUserWithFilter(
      {required String type, required String phoneNumber}) async {
    return await FirebaseFirestore.instance
        .collection(type)
        .withConverter<MyUser>(
          fromFirestore: (snapshots, _) =>
              MyUser.fromJson(jsonEncode(snapshots.data())),
          toFirestore: (user, _) => jsonDecode(user.toJson()),
        )
        .doc(phoneNumber)
        .get();
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('nurses');
  Future<List<Object?>> getUser({required String type}) async {
    QuerySnapshot querySnapshot = await _collectionRef
        .withConverter<MyUser>(
          fromFirestore: (snapshots, _) =>
              MyUser.fromJson(jsonEncode(snapshots.data())),
          toFirestore: (user, _) => jsonDecode(user.toJson()),
        )
        .get();

    final allData =
        querySnapshot.docs.map((doc) => doc.data() as MyUser).toList();

    return allData;
  }

  String get patientDocID => _patientDocId;
  String get nurseDocID => _nurseDocId;
}
