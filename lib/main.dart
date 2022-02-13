import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hemsirem/Screens/calendar_page.dart';
import 'package:hemsirem/Screens/create_new_task_page.dart';
import 'package:hemsirem/Screens/mytasks_page.dart';

import 'Constant/page_names.dart';
import 'Screens/home_page.dart';
import 'Screens/login_page.dart';
import 'Screens/register_pages.dart';
import 'Theme/theme.dart';
import 'Theme/colors/light_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
        PageNames.kPlannedTasksScreenName: (context) => const MyPlannedTasks(),
        PageNames.kCreateTaskScreenName: (context) => const CreateNewTaskPage(),
        PageNames.kCalenderScreenName: (context) => CalendarPage(),
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
      debugShowCheckedModeBanner: kDebugMode,
    );
  }
}
