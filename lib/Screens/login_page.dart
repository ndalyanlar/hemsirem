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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: LightColors.kLightRed2,
        body: Container(
          width: double.infinity,
          color: LightColors.kLightWhite2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.1),
              Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(
                    "Giriş",
                    style: TextStyle(
                        color: LightColors.kLoginTextColor, fontSize: 48),
                  )),
              SizedBox(height: height * 0.015),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Hoş Geldiniz!",
                  style: TextStyle(
                      color: LightColors.kLoginTextColor, fontSize: 24),
                ),
              ),
              SizedBox(height: height * 0.045),
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
              LightColors.kLightRed2,
              LightColors.kLightRed3,
              LightColors.kLightRed4
            ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppTheme.loginPageborderRadius),
                topRight: Radius.circular(AppTheme.loginPageborderRadius))),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final provider = ref.watch(loginStatusProvider);
                const hastaRole = Who.HASTA;
                const hemsireRole = Who.HEMSIRE;

                return Column(
                  children: [
                    buildRow(provider, hastaRole, hemsireRole),
                    const BuildForm(),
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
                    const Text("HEMŞİREM",
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
              borderRadius: BorderRadiusDirectional.circular(
                  AppTheme.loginPageborderRadius),
              color: provider.whoIs == hastaRole
                  ? LightColors.kLoginTextColor
                  : null,
            ),
            child: TextButton(
                onPressed: () {
                  provider.selectRole(Who.HASTA);
                },
                child: Text(
                  Who.HASTA.name,
                  style: TextStyle(
                      color: provider.whoIs == hastaRole
                          ? LightColors.kLightWhite2
                          : LightColors.kLoginTextColor),
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
              borderRadius: BorderRadiusDirectional.circular(
                  AppTheme.loginPageborderRadius),
              color: provider.whoIs == hemsireRole
                  ? LightColors.kLoginTextColor
                  : null,
            ),
            child: TextButton(
                onPressed: () {
                  provider.selectRole(Who.HEMSIRE);
                },
                child: Text(Who.HEMSIRE.name,
                    style: TextStyle(
                        color: provider.whoIs == hemsireRole
                            ? LightColors.kLightWhite2
                            : LightColors.kLoginTextColor))),
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
    double height = MediaQuery.of(context).size.height;
    final provider = ref.watch(loginStatusProvider);
    // ignore: unused_local_variable
    final auth = ref.watch(authProvider);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 0, bottom: 0),
            decoration: BoxDecoration(
                color: LightColors.kLightWhite2,
                borderRadius:
                    BorderRadius.circular(AppTheme.loginPageborderRadius),
                boxShadow: const [
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
              decoration: InputDecoration(
                  labelText: "Telefon Numarasi Giriniz",
                  labelStyle: TextStyle(
                    color: LightColors.kLoginTextColor,
                    fontSize: 16,
                  ),
                  border: InputBorder.none),
              onSaved: (value) {
                provider.telephone = value!;
              },
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: LightColors.kLightWhite2,
                borderRadius:
                    BorderRadius.circular(AppTheme.loginPageborderRadius),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Şifrenizi giriniz",
                labelStyle:
                    TextStyle(color: LightColors.kLoginTextColor, fontSize: 16),
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
            height: height * 0.02,
          ),
          TextButton(
              style: const ButtonStyle(
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () {},
              child: Text(
                "Şifremi Unuttum.",
                style: TextStyle(color: LightColors.kLightWhite2, fontSize: 16),
              )),
          SizedBox(
            height: height * 0.02,
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
                  switch (provider.whoIs) {
                    case Who.HASTA:
                      data = await FirebaseDocName().getUserWithFilter(
                          type: Who.HASTA.firebaseCollectionName,
                          phoneNumber:
                              provider.telephone.replaceAll("+9", "").trim());
                      break;
                    case Who.HEMSIRE:
                      data = await FirebaseDocName().getUserWithFilter(
                          type: Who.HEMSIRE.firebaseCollectionName,
                          phoneNumber:
                              provider.telephone.replaceAll("+9", "").trim());
                      break;
                  }

                  MyUser user = ((data.data() ??
                      MyUser(
                          name: "",
                          surName: "",
                          phone: "",
                          password: "",
                          age: 0,
                          role: '')) as MyUser);

                  if (user.password == _controllerPass.text &&
                      _controllerPhone.text.contains(user.phone)) {
                    // await auth.registerUser(
                    //   user,
                    //   provider.telephone,
                    //   context,
                    // );

                    Navigator.pushReplacementNamed(
                        context, PageNames.kHomeScreenName,
                        arguments: user);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      dismissDirection: DismissDirection.startToEnd,
                      content: Center(
                        child: Text(
                          'Giriş Başarılı',
                        ),
                      ),
                      backgroundColor: Color.fromARGB(255, 5, 94, 39),
                    ));
                    log("success");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      // dismissDirection: DismissDirection.vertical,
                      content: SizedBox(
                        height: height * 0.1,
                        child: Text(
                          'Giriş Hatalı',
                          textAlign: TextAlign.center,
                          style: AppTheme.LoginPageButtonsTextStyle.copyWith(
                              color: LightColors.kLightWhite),
                        ),
                      ),
                      backgroundColor: LightColors.kSnackbarBGColor,
                    ));
                  }
                }
              }),
        ],
      ),
    );
  }
}
