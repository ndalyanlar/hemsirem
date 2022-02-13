import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hemsirem/Theme/colors/light_colors.dart';
import 'package:hemsirem/Theme/theme.dart';

import '../Widgets/expanded_card.dart';

class MyPlannedTasks extends StatefulWidget {
  MyPlannedTasks({Key? key}) : super(key: key);
  @override
  State<MyPlannedTasks> createState() => _MyPlannedTasksState();
}

bool isExpanded = false;
Icon todoIcon = Icon(Icons.timelapse);
Icon doneIcon = Icon(Icons.done);

class _MyPlannedTasksState extends State<MyPlannedTasks> {
  @override
  void didChangeDependencies() {
    type = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  late String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: type == "ToDo"
              ? Text("Yapacağım Hizmetler")
              : Text("Yaptığım Hizmetler"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: AppTheme.pagePadding,
            child: type == "ToDo"
                ? Column(
                    children: [
                      ExpandedCardWidget(
                        title: "İnsülin İğnesi",
                        desc: "Reçeteli İnsülin İğnesi Vurulacaktır",
                        date: DateTime.parse("20220227 1430"),
                        startTime: DateTime.parse("20220227 1430"),
                        endTime: DateTime.parse("20220227 1430")
                            .add(Duration(minutes: 15)),
                        patientName: "Melih Taskin",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: todoIcon,
                      ),
                      ExpandedCardWidget(
                        title: "COVİD-19 Aşısı",
                        desc: "Covid-19 Aşısı Vurulacaktır",
                        date: DateTime.parse("20220217 1730"),
                        startTime: DateTime.parse("20220217 1730"),
                        endTime: DateTime.parse("20220217 1730")
                            .add(Duration(minutes: 5)),
                        patientName: "Nihatcan Dalyanlar",
                        location: LatLng(41.13334874293148, 28.976015397287947),
                        icon: todoIcon,
                      ),
                      ExpandedCardWidget(
                        title: "Basit Sağlık Kontrolleri",
                        desc:
                            "Tansiyon, nabız gibi sağlık kontrolleri yapılacaktır",
                        date: DateTime.parse("20220214 1615"),
                        startTime: DateTime.parse("20220214 1615"),
                        endTime: DateTime.parse("20220214 1615")
                            .add(Duration(minutes: 40)),
                        patientName: "Ayşe Sönmez",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: todoIcon,
                      ),
                      ExpandedCardWidget(
                        title: "İnsülin İğnesi",
                        desc: "Reçetesiz İnsülin İğnesi Vurulacaktır",
                        date: DateTime.parse("20220221 1230"),
                        startTime: DateTime.parse("20220221 1230"),
                        endTime: DateTime.parse("20220221 1230")
                            .add(Duration(minutes: 15)),
                        patientName: "Berkay Küçük",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: todoIcon,
                      ),
                      ExpandedCardWidget(
                        title: "Serum yapılacak",
                        desc: "Reçeteli Serum İlacı Hazırlanacak",
                        date: DateTime.parse("20220215 1830"),
                        startTime: DateTime.parse("20220215 1430"),
                        endTime: DateTime.parse("20220215 1430")
                            .add(Duration(minutes: 15)),
                        patientName: "Umar Beyoğlu",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: todoIcon,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ExpandedCardWidget(
                        title: "Basit Sağlık Kontrolü",
                        desc: "Sağlık Kontrolü  Yapılacak",
                        date: DateTime.parse("20220202 1430"),
                        startTime: DateTime.parse("20220202 1430"),
                        endTime: DateTime.parse("20220202 1430")
                            .add(Duration(minutes: 15)),
                        patientName: "Melih Taskin",
                        location: LatLng(41.02234864293248, 28.963015697286947),
                        icon: doneIcon,
                      ),
                      ExpandedCardWidget(
                        title: "Yara Bakımı",
                        desc: "Pansuman yapılacak",
                        date: DateTime.parse("20220114 1030"),
                        startTime: DateTime.parse("20220114 1030"),
                        endTime: DateTime.parse("20220114 1030")
                            .add(Duration(minutes: 15)),
                        patientName: "Kerem Ersoy",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: doneIcon,
                      ),
                      ExpandedCardWidget(
                        title: "Serum ilaç hazırlanması",
                        desc: "Serum hazırlancak ve damaryolu açılacak",
                        date: DateTime.parse("20220112 0930"),
                        startTime: DateTime.parse("20220112 0930"),
                        endTime: DateTime.parse("20220112 0930")
                            .add(Duration(minutes: 25)),
                        patientName: "Damla Ozturk",
                        location: LatLng(41.02234864293248, 28.978015697286947),
                        icon: doneIcon,
                      ),
                      ExpandedCardWidget(
                        title: "Hormon İğnesi",
                        desc: "Reçeteli İnsülin İğnesi Vurulacaktır",
                        date: DateTime.parse("20220125 1430"),
                        startTime: DateTime.parse("20220125 1430"),
                        endTime: DateTime.parse("20220125 1430")
                            .add(Duration(minutes: 15)),
                        patientName: "Melih Taskin",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: doneIcon,
                      ),
                      ExpandedCardWidget(
                        title: "COVID-19 Aşısı",
                        desc: "Covid-19 Aşısı Vurulacaktır",
                        date: DateTime.parse("20220202 1430"),
                        startTime: DateTime.parse("20220202 1430"),
                        endTime: DateTime.parse("20220202 1430")
                            .add(Duration(minutes: 15)),
                        patientName: "Melih Taskin",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: doneIcon,
                      ),
                      ExpandedCardWidget(
                        title: "Kızamık Aşısı",
                        desc: "Kızamık Aşısı Vurulacaktır",
                        date: DateTime.parse("20220201 1430"),
                        startTime: DateTime.parse("20220201 1430"),
                        endTime: DateTime.parse("20220201 1430")
                            .add(Duration(minutes: 15)),
                        patientName: "Nihatcan Dalyanlar",
                        location: LatLng(41.02234864293248, 28.973015697286947),
                        icon: doneIcon,
                      ),
                    ],
                  ),
          ),
        ));
  }
}
