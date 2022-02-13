import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemsirem/Constant/page_names.dart';
import 'package:hemsirem/Core/login_modal_view.dart';
import 'package:hemsirem/Model/user.dart';

import 'package:hemsirem/Theme/theme.dart';

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
      backgroundColor: LightColors.kDarkBlue,
      child: Icon(
        Icons.add,
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

  Text subheading(String title) {
    return Text(title,
        style: AppTheme.homePageTextStyle.copyWith(
            letterSpacing: 1.2, fontWeight: FontWeight.w600, fontSize: 24));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: LightColors.kLightWhite,
      body: Column(
        children: <Widget>[
          buildTopContainer(height, width),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildMyTasks(context, height),
                  buildActiveTasks(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TopContainer buildTopContainer(double height, double width) {
    return TopContainer(
      height: height * 0.3,
      width: width,
      padding: null,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: Image.asset(
                'assets/images/icontwo.png',
              ),
            ),
            buildUserInfo(),
          ],
        ),
      ),
    );
  }

  Container buildActiveTasks() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          subheading('Aktif Hizmetler'),
          const SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              ActiveProjectsCard(
                  cardColor: LightColors.kGreen,
                  title: 'Sağlık Kontrol',
                  subtitle: '9 Hizmet Bekliyor...',
                  icon: Icon(
                    Icons.medical_services_outlined,
                    color: LightColors.kLightWhite,
                    size: 100,
                  )),
              const SizedBox(width: 20.0),
              ActiveProjectsCard(
                cardColor: LightColors.kRed,
                title: 'İğne',
                subtitle: '20 Hizmet Bekliyor...',
                icon: Icon(
                  FontAwesomeIcons.syringe,
                  color: LightColors.kLightWhite,
                  size: 100,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              ActiveProjectsCard(
                  cardColor: LightColors.kDarkYellow,
                  title: 'Aşı',
                  subtitle: '5 Hizmet Bekliyor...',
                  icon: Icon(
                    FontAwesomeIcons.clinicMedical,
                    color: LightColors.kLightWhite,
                    size: 100,
                  )),
              const SizedBox(width: 20.0),
              ActiveProjectsCard(
                  cardColor: LightColors.kBlue,
                  title: 'Serum',
                  subtitle: '23 Hizmet Bekliyor...',
                  icon: Icon(
                    FontAwesomeIcons.pills,
                    color: LightColors.kLightWhite,
                    size: 100,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Container buildMyTasks(BuildContext context, double height) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              subheading('Hizmetlerim'),
              user.role == Who.HASTA.name
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PageNames.kCalenderScreenName,
                            arguments: user);
                      },
                      child: HomePage.calendarIcon(),
                    )
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: height * 0.005),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageNames.kPlannedTasksScreenName,
                  arguments: "ToDo");
            },
            child: TaskColumn(
                icon: Icons.alarm,
                iconBackgroundColor: LightColors.kRed,
                title: user.role == "HEMŞİRE"
                    ? 'Yapılacak Sağlık Hizmetleri'
                    : 'Alacağım Sağlık Hizmetleri',
                subtitle: '5 Hizmet'),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageNames.kPlannedTasksScreenName,
                  arguments: "Done");
            },
            child: TaskColumn(
                icon: Icons.check_circle_outline,
                iconBackgroundColor: LightColors.kBlue,
                title: user.role == "HEMŞİRE"
                    ? 'Yapılmış Sağlık Hizmetleri'
                    : 'Aldığım Sağlık Hizmetleri',
                subtitle: '6 Hizmet'),
          ),
        ],
      ),
    );
  }

  Expanded buildUserInfo() {
    return Expanded(
      child: Column(
        children: [
          Text("${user.name} ${user.surName}",
              textAlign: TextAlign.start,
              style: AppTheme.homePageTextStyle
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w600)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          CircleAvatar(
            backgroundColor: LightColors.kLightWhite,
            child: Text("${user.age}",
                textAlign: TextAlign.start,
                style: AppTheme.homePageTextStyle
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(user.role,
              textAlign: TextAlign.start,
              style: AppTheme.homePageTextStyle
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
