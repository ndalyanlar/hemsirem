import 'package:flutter/material.dart';
import 'package:hemsirem/Theme/colors/light_colors.dart';
import 'package:hemsirem/Theme/theme.dart';

import '../Widgets/expanded_card.dart';

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
        appBar: AppBar(
          title: Text("Yapacağım Hizmetler"),
        ),
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
                  patientName: "Melih Taskin",
                ),
                ExpandedCardWidget(
                  title: "Aşı İğnesi",
                  desc: "Reçeteli Aşı İğnesi Vurulacaktır",
                  date: DateTime.now(),
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(Duration(hours: 5)),
                  patientName: "Melih Taskin",
                )
              ],
            ),
          ),
        ));
  }
}
