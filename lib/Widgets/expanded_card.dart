import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../Theme/colors/light_colors.dart';
import '../Theme/theme.dart';

class ExpandedCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String patientName;
  final LatLng location;

  const ExpandedCardWidget({
    Key? key,
    required this.title,
    required this.desc,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.patientName,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.loginPageborderRadius),
          side: BorderSide(color: LightColors.kLightRed3)),
      child: ExpansionTile(
          subtitle: Container(
            alignment: Alignment.center,
            child: Text(
              patientName,
              style: AppTheme.homePageTextStyle.copyWith(fontSize: 14),
            ),
          ),
          leading: Container(
              padding: const EdgeInsets.only(top: 8),
              child: const Icon(Icons.timelapse)),
          title: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: AppTheme.homePageTextStyle.copyWith(fontSize: 16),
            ),
          ),
          children: [
            Container(
              child: Text(desc),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(children: [
                Expanded(
                  child: Container(
                    child: Text(formattedDate),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Container(
                  child: Text(
                      "${endTime.minute.toInt() - startTime.minute.toInt()} Dakikalik Hizmet"),
                  alignment: Alignment.centerLeft,
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: 300,
              height: 200,
              child: GoogleMap(
                  markers: {
                    Marker(
                        markerId: const MarkerId("Location"),
                        position: location)
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(41.0225311, 28.9719733),
                    zoom: 14.4746,
                  )),
            ),
          ]),
    );
  }
}
