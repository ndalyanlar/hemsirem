import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Theme/colors/light_colors.dart';
import '../Theme/theme.dart';

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
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.loginPageborderRadius),
          side: BorderSide(color: LightColors.kLightRed3)),
      child: ExpansionTile(title: Text(title), children: [
        Text(desc),
        Text(formattedDate),
        Text("${endTime.hour.toInt() - startTime.hour.toInt()} saatlik hizmet")
      ]),
    );
  }
}
