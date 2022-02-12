import 'package:flutter/material.dart';

import '../Widgets/top_container.dart';
import '../Theme/colors/light_colors.dart';
import '../widgets/active_project_card.dart';
import '../Widgets/task_column.dart';

import 'calendar_page.dart';

class HomePage extends StatelessWidget {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
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
                  // CircularPercentIndicator(
                  //   radius: 70.0,
                  //   lineWidth: 5.0,
                  //   animation: true,
                  //   percent: 1,
                  //   circularStrokeCap: CircularStrokeCap.round,
                  //   progressColor: LightColors.kLightYellow,
                  //   backgroundColor: LightColors.kLightRed2,
                  //   center: CircleAvatar(
                  //     backgroundColor: LightColors.kBlue,
                  //     radius: 35.0,
                  //     backgroundImage: AssetImage(
                  //       'assets/images/avatar.png',
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Sourav Suman',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '28, Ankara',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
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
                      padding: EdgeInsets.symmetric(
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
                                child: calendarIcon(),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          subheading('Active Projects'),
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kGreen,
                                loadingPercent: 0.25,
                                title: 'Medical App',
                                subtitle: '9 hours progress',
                              ),
                              SizedBox(width: 20.0),
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
                              SizedBox(width: 20.0),
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
