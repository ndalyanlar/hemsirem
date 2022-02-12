import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Constant/firestore_constant.dart';
import '../Model/register_page_arg.dart';
import '../Model/user.dart';
import '../Theme/colors/light_colors.dart';
import '../Theme/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late ScreenArguments who;
  @override
  void didChangeDependencies() {
    who = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    super.didChangeDependencies();
  }

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerTel = TextEditingController();

  final TextEditingController _controllerPass1 = TextEditingController();
  final TextEditingController _controllerPass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${who.role} Kayıt Formu"),
      ),
      body: Center(
        child: Padding(
          padding: AppTheme.pagePadding,
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: SingleChildScrollView(
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildtextField("İsim girin", _controllerName),
                  buildtextField("Soyad girin", _controllerSurName),
                  buildtextField("Yaşınızı girin", _controllerAge),
                  buildtextField("Telefon girin", _controllerTel),
                  buildtextField("Şifre girin", _controllerPass1),
                  buildtextField("Şifre tekrar girin", _controllerPass2),
                  buildSignInButton(
                      name: _controllerName,
                      surname: _controllerSurName,
                      tel: _controllerTel,
                      pass1: _controllerPass1,
                      pass2: _controllerPass2,
                      screenArguments: who,
                      age: _controllerAge),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildSignInButton({
    required TextEditingController name,
    required TextEditingController surname,
    required TextEditingController age,
    required TextEditingController tel,
    required TextEditingController pass1,
    required TextEditingController pass2,
    required ScreenArguments screenArguments,
  }) {
    return TextButton(
        onPressed: () async {
          User user = User(
              name: name.text,
              surName: surname.text,
              phone: tel.text,
              password: pass1.text,
              age: int.parse(age.text));
          if (screenArguments.role == "HASTA") {
            String key = FirebaseDocName().patientDocID;
            await FirebaseDocName().getUserRef(key).doc().set(user);
          } else {
            String key = FirebaseDocName().nurseDocID;
            await FirebaseDocName().getUserRef(key).doc().set(user);
          }
          log("success");
        },
        child: Container(
          decoration: BoxDecoration(
              color: LightColors.kDarkBlue,
              borderRadius: BorderRadiusDirectional.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Kayıt Ol",
              style: AppTheme.buttonRegisterTextStyle,
            ),
          ),
        ));
  }

  Widget buildtextField(
      String type, TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: AppTheme.textFieldContainerPadding,
        decoration: BoxDecoration(
            color: LightColors.kLightWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))
            ]),
        child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: type,
              hintStyle: TextStyle(color: Colors.black26),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
