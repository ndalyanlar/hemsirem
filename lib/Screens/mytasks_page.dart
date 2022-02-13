import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                  title: "İnsülin İğnesi",
                  desc: "Reçeteli İnsülin İğnesi Vurulacaktır",
                  date: DateTime.parse("20220202 1430"),
                  startTime: DateTime.parse("20220202 1430"),
                  endTime: DateTime.parse("20220202 1430")
                      .add(Duration(minutes: 15)),
                  patientName: "Melih Taskin",
                  location: LatLng(41.02234864293248, 28.973015697286947),
                ),
                ExpandedCardWidget(
                  title: "COVİD-19 Aşısı",
                  desc: "Covid-19 Aşısı Vurulacaktır",
                  date: DateTime.parse("20220211 1730"),
                  startTime: DateTime.parse("20220211 1730"),
                  endTime:
                      DateTime.parse("20220211 1730").add(Duration(minutes: 5)),
                  patientName: "Melih Taskin",
                  location: LatLng(41.02234874293148, 28.976015397287947),
                )
              ],
            ),
          ),
        ));
  }
}
