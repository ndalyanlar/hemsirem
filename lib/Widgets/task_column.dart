import 'package:flutter/material.dart';
import 'package:hemsirem/Theme/theme.dart';

class TaskColumn extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;

  TaskColumn({
    Key? key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: iconBackgroundColor,
          child: Icon(
            icon,
            size: 15.0,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: AppTheme.homePageTextStyle
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
            Text(subtitle,
                style: AppTheme.homePageTextStyle
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
          ],
        )
      ],
    );
  }
}
