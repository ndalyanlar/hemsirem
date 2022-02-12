import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hemsirem/Constant/firestore_constant.dart';
import 'package:hemsirem/Model/user.dart';
import '../Model/register_page_arg.dart';
import '../Constant/page_names.dart';
import '../Core/login_modal_view.dart';
import '../Extension/who_extension.dart';
import '../Theme/colors/light_colors.dart';
import '../Theme/theme.dart';

final loginStatusProvider = ChangeNotifierProvider(((ref) => LoginModelView()));

TextEditingController _controllerPhone = TextEditingController();
TextEditingController _controllerPass = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      color: LightColors.kLightWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                "Giriş",
                style: TextStyle(color: Colors.black38, fontSize: 48),
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              "Hoş Geldiniz!",
              style: TextStyle(color: Colors.black38, fontSize: 24),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
          ),
          buildMain()
        ],
      ),
    ));
  }

  Expanded buildMain() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.red.shade200,
              Colors.red.shade300,
              Colors.red.shade400
            ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final provider = ref.watch(loginStatusProvider);
                final hastaRole = Who.HASTA;
                final hemsireRole = Who.HEMSIRE;

                return Column(
                  children: [
                    buildRow(provider, hastaRole, hemsireRole),
                    BuildForm(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    buildRegisterButton(provider, hastaRole, context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Image.asset(
                      'assets/images/icontwo.png',
                      width: 100,
                      height: 100,
                    ),
                    Text("HEMŞİREM",
                        style: TextStyle(color: Colors.white, fontSize: 24))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildRegisterButton(
      LoginModelView provider, Who hastaRole, BuildContext context) {
    return ElevatedButton(
        style: AppTheme.loginPageButtonStyle,
        child: Text("Kayıt Ol", style: AppTheme.LoginPageButtonsTextStyle),
        onPressed: () {
          Navigator.pushNamed(context, PageNames.kRegisterScreenName,
              arguments: ScreenArguments(provider.whoIs.name));
        });
  }

  Row buildRow(LoginModelView provider, Who hastaRole, Who hemsireRole) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(16),
              color: provider.whoIs == hastaRole ? Colors.black45 : null,
            ),
            child: TextButton(
                onPressed: () {
                  provider.selectRole(Who.HASTA);
                },
                child: Text(
                  Who.HASTA.name,
                  style: TextStyle(
                      color: provider.whoIs == hastaRole
                          ? Colors.white70
                          : Colors.black),
                )),
          ),
        )),
        Container(
          color: Colors.black,
          width: 1,
          height: 15,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(16),
              color: provider.whoIs == hemsireRole ? Colors.black45 : null,
            ),
            child: TextButton(
                onPressed: () {
                  provider.selectRole(Who.HEMSIRE);
                },
                child: Text(Who.HEMSIRE.name,
                    style: TextStyle(
                        color: provider.whoIs == hemsireRole
                            ? Colors.white70
                            : Colors.black))),
          ),
        ))
      ],
    );
  }
}

class BuildForm extends ConsumerStatefulWidget {
  const BuildForm({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends ConsumerState<BuildForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controllerPhone.text = "+90";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(loginStatusProvider);
    final auth = ref.watch(authProvider);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(right: 15, left: 15, top: 0, bottom: 0),
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9, +]')),
                LengthLimitingTextInputFormatter(13)
              ],
              controller: _controllerPhone,
              validator: (value) {
                if (value!.length != 13) {
                  return 'Telefon numaranı kontrol et';
                }
                return null;
              },
              // initialValue: "+90",
              decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 12),
                  labelText: "Telefon Numarasi Giriniz",
                  labelStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 16,
                  ),
                  border: InputBorder.none),
              onSaved: (value) {
                provider.telephone = value!;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Şifrenizi giriniz",
                labelStyle: TextStyle(color: Colors.black38, fontSize: 16),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen şifrenizi giriniz!';
                }
                return null;
              },
              controller: _controllerPass,
              onSaved: (value) {
                provider.password = value!;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextButton(
              style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () {},
              child: Text(
                "Şifremi Unuttum.",
                style: TextStyle(color: Colors.white60, fontSize: 16),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          ElevatedButton(
              style: AppTheme.loginPageButtonStyle,
              child: Text(
                "Giriş",
                style: AppTheme.LoginPageButtonsTextStyle,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Giriş Yapılıyor')));
                  _formKey.currentState!.save();

                  DocumentSnapshot data;
                  // DocumentSnapshot data = await FirebaseFirestore.instance
                  //     .collection("patients")
                  //     .doc(_controllerPhone.text)
                  //     .get();
                  switch (provider.whoIs) {
                    case Who.HASTA:
                      data = await FirebaseDocName().getUser(
                          type: Who.HASTA.firebaseCollectionName,
                          phoneNumber:
                              provider.telephone.replaceAll("+9", "").trim());
                      break;
                    case Who.HEMSIRE:
                      data = await FirebaseDocName().getUser(
                          type: Who.HEMSIRE.firebaseCollectionName,
                          phoneNumber:
                              provider.telephone.replaceAll("+9", "").trim());
                      break;
                  }

                  User user = ((data.data() ??
                      User(
                          name: "",
                          surName: "",
                          phone: "",
                          password: "",
                          age: 0)) as User);

                  if (user.password == _controllerPass.text &&
                      _controllerPhone.text.contains(user.phone)) {
                    await auth.registerUser(provider.telephone, context);
                    log("success");
                  } else {
                    // ScaffoldMessenger.of(context).showMaterialBanner(
                    //     MaterialBanner(content: context, actions: []));
                  }

                  // auth.registerUser(provider.telephone, context);
                }
              }),
        ],
      ),
    );
  }
}

class Navigation {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey();
}

class OverlayHelper {
  static final OverlayHelper instance = OverlayHelper();
  final overlayState = Overlay.of(Navigation.navigationKey.currentContext!);
  final overlayEntry = OverlayEntry(
      builder: (context) => Container(
            color: Colors.black38,
            alignment: Alignment.center,
            child: const CircularProgressIndicator.adaptive(),
          ));
  Future<void> showOverlay() async {
    overlayState?.insert(overlayEntry);
  }

  Future<void> closeOverlay() async {
    overlayEntry.remove();
  }
}
