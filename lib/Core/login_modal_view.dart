import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Constant/page_names.dart';
import '../Model/user.dart';

class LoginModelView extends ChangeNotifier {
  late String telephone;
  late String password;

  Who whoIs = Who.HASTA;

  void selectRole(Who who) {
    whoIs = who;
    notifyListeners();
  }

  void addTelAndPass(String tel, String pass) {
    telephone = tel;
    password = pass;
    notifyListeners();
  }
}

class Auth extends ChangeNotifier {
  Future registerUser(String mobile, BuildContext context,
      {required MyUser user}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {},
        verificationFailed: (e) {},
        codeSent: (String verificationId, [int? forceResendingToken]) {
          var _codeController = TextEditingController();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Platform.isIOS
                  ? CupertinoAlertDialog(
                      title: const Text("Enter SMS Code"),
                      content: Material(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              controller: _codeController,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Done"),
                          // textColor: Colors.white,
                          // color: Colors.redAccent,
                          onPressed: () {
                            FirebaseAuth auth = FirebaseAuth.instance;

                            var smsCode = _codeController.text.trim();

                            var _credential = PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: smsCode);
                            auth
                                .signInWithCredential(_credential)
                                .then((UserCredential result) {
                              Navigator.popAndPushNamed(
                                  context, PageNames.kHomeScreenName,
                                  arguments: user);
                              // Navigator.of(context).pop();
                            }).catchError((e) {
                              if (kDebugMode) {
                                print(e);
                              }
                            });
                          },
                        )
                      ],
                    )
                  : AlertDialog(
                      title: const Text("Enter SMS Code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            controller: _codeController,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Done"),
                          // textColor: Colors.white,
                          // color: Colors.redAccent,
                          onPressed: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            var smsCode = _codeController.text.trim();

                            var _credential = PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: smsCode);
                            auth
                                .signInWithCredential(_credential)
                                .then((UserCredential result) {
                              Navigator.pushReplacementNamed(
                                  context, PageNames.kHomeScreenName,
                                  arguments: user);
                            }).catchError((e) {
                              if (kDebugMode) {
                                print(e);
                              }
                            });
                          },
                        )
                      ],
                    ));
        },
        codeAutoRetrievalTimeout: (t) {
          // log(t.toString());
        });
  }
}

final authProvider = ChangeNotifierProvider(((ref) => Auth()));

enum Who {
  HASTA,
  HEMSIRE,
}
