import 'package:flutter/material.dart';
import 'package:hemsirem/Model/user.dart';
import 'package:hemsirem/Widgets/active_project_card.dart';
import 'package:hemsirem/Widgets/task_container.dart';

import '../Widgets/top_container.dart';
import '../Theme/colors/light_colors.dart';
import '../Widgets/active_project_card.dart';
import '../Widgets/task_column.dart';

import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static CircleAvatar calendarIcon() {
    return const CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MyUser user;
  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as MyUser;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: LightColors.kLightWhite,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: height * 0.3,
              width: width,
              padding: null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${user.name} ${user.surName}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 22.0,
                            color: LightColors.kDarkBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "${user.age}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          user.role,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 22.0,
                            color: LightColors.kDarkBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Hizmetlerim'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CalendarPage()),
                                  );
                                },
                                child: HomePage.calendarIcon(),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.005),
                          TaskColumn(
                            icon: Icons.alarm,
                            iconBackgroundColor: LightColors.kRed,
                            title: 'Yapılacak Sağlık Hizmetleri',
                            subtitle: '5 görev',
                            onPressed: () {},
                          ),
                          SizedBox(height: height * 0.02),
                          TaskColumn(
                            icon: Icons.blur_circular,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'Yapılmakta Olan Sağlık Hizmetleri',
                            subtitle: '1 Görev',
                            onPressed: () {},
                          ),
                          SizedBox(height: height * 0.02),
                          InkWell(
                            child: TaskColumn(
                              icon: Icons.check_circle_outline,
                              iconBackgroundColor: LightColors.kBlue,
                              title: 'Yapılmış Sağlık Hizmetleri',
                              subtitle: '18 Görev',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          subheading('Active Projects'),
                          const SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kGreen,
                                loadingPercent: 0.25,
                                title: 'Medical App',
                                subtitle: '9 hours progress',
                              ),
                              const SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kRed,
                                loadingPercent: 0.6,
                                title: 'Making History Notes',
                                subtitle: '20 hours progress',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kDarkYellow,
                                loadingPercent: 0.45,
                                title: 'Sports App',
                                subtitle: '5 hours progress',
                              ),
                              const SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kBlue,
                                loadingPercent: 0.9,
                                title: 'Online Flutter Course',
                                subtitle: '23 hours progress',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
