import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Constant/page_names.dart';
import 'Screens/home_page.dart';
import 'Screens/login_page.dart';
import 'Screens/register_pages.dart';
import 'Theme/theme.dart';
import 'theme/colors/light_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: LightColors.kStatusBarCcolor, // status bar color
  ));

  return runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        PageNames.kHomeScreenName: (context) => const HomePage(),
        PageNames.kRegisterScreenName: (context) => const RegisterPage(),
      },
      title: 'Hemsirem',
      theme: ThemeData(
        appBarTheme: AppTheme.appBarTheme,
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
