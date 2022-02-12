import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/user.dart';

class FirebaseDocName {
  String _patientDocId = "YpuplXWVjzC4Ly5S3xhF";
  String _nurseDocId = "WfY14Nr3qFLCBWns4AyS";

  CollectionReference<User> getUserRef(String name) {
    return FirebaseFirestore.instance.collection(name).withConverter<User>(
          fromFirestore: (snapshots, _) =>
              User.fromJson(jsonEncode(snapshots.data())),
          toFirestore: (user, _) => jsonDecode(user.toJson()),
        );
  }

  String get patientDocID => _patientDocId;
  String get nurseDocID => _nurseDocId;
}
