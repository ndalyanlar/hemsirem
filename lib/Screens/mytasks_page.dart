import 'package:flutter/material.dart';
import 'package:hemsirem/Theme/colors/light_colors.dart';
import 'package:hemsirem/Theme/theme.dart';

class MyPlannedTasks extends StatefulWidget {
  const MyPlannedTasks({Key? key}) : super(key: key);

  @override
  State<MyPlannedTasks> createState() => _MyPlannedTasksState();
}

bool isExpanded = false;

class _MyPlannedTasksState extends State<MyPlannedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: AppTheme.pagePadding,
            child: Column(
              children: [
                ExpandedCardWidget(
                  title: "Aşı İğnesi",
                  desc: "Reçeteli Aşı İğnesi Vurulacaktır",
                  date: DateTime.now(),
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(Duration(hours: 5)),
                )
              ],
            ),
          ),
        ));
  }
}

class ExpandedCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;

  const ExpandedCardWidget({
    Key? key,
    required this.title,
    required this.desc,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.loginPageborderRadius),
          side: BorderSide(color: LightColors.kLightRed3)),
      child: ExpansionTile(title: Text(title), children: [
        Text("desc"),
        Text('$date'),
        Text("${endTime.hour.toDouble() - startTime.hour.toDouble()}'lik iş")
      ]),
    );
  }
}
