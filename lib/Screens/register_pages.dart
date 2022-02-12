import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hemsirem/Constant/page_names.dart';
import 'package:hemsirem/Core/login_modal_view.dart';

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

final _formKey = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  late ScreenArguments who;
  @override
  void didChangeDependencies() {
    who = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    super.didChangeDependencies();
  }

  bool loading = false;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerTel = TextEditingController();

  final TextEditingController _controllerPass1 = TextEditingController();
  final TextEditingController _controllerPass2 = TextEditingController();

  @override
  void initState() {
    _controllerTel.text = "05";
    super.initState();
  }

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
              physics: MediaQuery.of(context).viewInsets.bottom != 0
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildtextField("İsim girin", _controllerName),
                      buildtextField("Soyad girin", _controllerSurName),
                      buildtextField("Yaşınızı girin", _controllerAge,
                          isNum: true),
                      buildtextField("Telefon girin", _controllerTel,
                          isNum: true, isPhone: true),
                      buildtextField("Şifre girin", _controllerPass1,
                          pass: true),
                      buildtextField("Şifre tekrar girin", _controllerPass2,
                          pass: true),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : buildSignInButton(
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
          setState(() {
            loading = (_formKey.currentState!.validate() &&
                _controllerPass1.text == _controllerPass2.text);
          });

          if (loading) {
            User user = User(
                name: name.text,
                surName: surname.text,
                phone: tel.text,
                password: pass1.text,
                age: age.text != "" ? int.parse(age.text) : 0);

            if (screenArguments.role == Who.HASTA.name) {
              await FirebaseDocName().addUser(
                  type: "patients",
                  user: user,
                  phoneNumber: _controllerTel.text);
            } else {
              await FirebaseDocName().addUser(
                  type: "nurses", user: user, phoneNumber: _controllerTel.text);
            }

            Navigator.pushReplacementNamed(context, PageNames.kHomeScreenName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Lütfen bilgileri kontrol ediniz'),
              backgroundColor: LightColors.kSnackbarBGColor,
            ));
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: LightColors.kDarkBlue,
              borderRadius: BorderRadiusDirectional.circular(10)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Kayıt Ol",
              style: AppTheme.buttonRegisterTextStyle,
            ),
          ),
        ));
  }

  Widget buildtextField(
      String type, TextEditingController textEditingController,
      {bool? isNum, bool? pass, bool? isPhone}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: AppTheme.textFieldContainerPadding,
        decoration: BoxDecoration(
            color: LightColors.kLightWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))
            ]),
        child: TextFormField(
          inputFormatters: isPhone ?? false
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(11)
                ]
              : null,
          validator: pass ?? false
              ? (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Lütfen şifrenizi giriniz!';
                  }
                  return null;
                }
              : isPhone ?? false
                  ? (value) {
                      if (value!.length != 11) {
                        return 'Telefon numaranı kontrol et';
                      }
                      return null;
                    }
                  : null,
          obscureText: pass ?? false,
          keyboardType: isNum ?? false ? TextInputType.number : null,
          controller: textEditingController,
          decoration: InputDecoration(
              label: Text(type),
              hintText: type,
              hintStyle: const TextStyle(color: Colors.black26),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
