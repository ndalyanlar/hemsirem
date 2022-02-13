import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hemsirem/Constant/firestore_constant.dart';
import 'package:hemsirem/Core/patient_model_view.dart';

import '../Model/disease.dart';
import '../Model/user.dart';
import '../Widgets/my_text_field.dart';
import '../Widgets/top_container.dart';
import '../theme/colors/light_colors.dart';
import '../widgets/back_button.dart';

import 'home_page.dart';

final patientsStatusProvider =
    ChangeNotifierProvider(((ref) => PatientModelView()));

class CreateNewTaskPage extends ConsumerWidget {
  const CreateNewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(patientsStatusProvider);

    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TopContainer(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            width: width,
            height: null,
            child: Column(
              children: <Widget>[
                Text(
                  'Randevu Oluştur',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                FutureBuilder(
                    future: provider.getNurseNamesFromFirebase(),
                    builder: (context, snapshot) {
                      provider.nurseNames.clear();
                      if (snapshot.connectionState == ConnectionState.done) {
                        (snapshot.data as List<MyUser>)
                            .toList()
                            .forEach((element) {
                          provider.nurseNames.add(element);
                        });
                        provider.nurseNames.toSet();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Hemşire Seç:",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: DropdownButton(
                                value: provider.nurseName ??
                                    provider.nurseNames.first.name,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: provider.nurseNames.map((element) {
                                  return DropdownMenuItem(
                                    value: element.name,
                                    child: Text(
                                        "${element.name} ${element.surName}"),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  provider.setNurseName(newValue!);
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyTextField(
                      label: 'Title',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: MyTextField(
                            label: 'Date',
                            icon: downwardIcon,
                          ),
                        ),
                        HomePage.calendarIcon(),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: MyTextField(
                      label: 'Start Time',
                      icon: downwardIcon,
                    )),
                    SizedBox(width: 40),
                    Expanded(
                      child: MyTextField(
                        label: 'End Time',
                        icon: downwardIcon,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyTextField(
                  label: 'Description',
                  minLines: 3,
                  maxLines: 3,
                  icon: null,
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        //direction: Axis.vertical,
                        alignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        runSpacing: 0,
                        //textDirection: TextDirection.rtl,
                        spacing: 10.0,
                        children: <Widget>[
                          for (var i in provider.disaseList)
                            Chip(
                              onDeleted: () {},
                              label: Text(i.name),
                              backgroundColor: LightColors.kRed,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
          Container(
            height: 80,
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Text(
                    'Create Task',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  width: width - 40,
                  decoration: BoxDecoration(
                    color: LightColors.kBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
