import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hemsirem/Constant/firestore_constant.dart';
import 'package:hemsirem/Core/patient_model_view.dart';
import 'package:hemsirem/Model/appointment.dart';
import '../Model/disease.dart';
import '../Model/user.dart';
import '../Widgets/my_text_field.dart';
import '../Widgets/top_container.dart';
import '../theme/colors/light_colors.dart';

import 'home_page.dart';

final patientsStatusProvider =
    ChangeNotifierProvider(((ref) => PatientModelView()));

class CreateNewTaskPage extends ConsumerWidget {
  const CreateNewTaskPage({Key? key}) : super(key: key);

  // final ChangeNotifierProvider<PatientModelView> patientsUserProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(patientsStatusProvider);
    final patient = ModalRoute.of(context)!.settings.arguments as MyUser;

    double width = MediaQuery.of(context).size.width;
    var downwardIcon = const Icon(
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
                const Text(
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

                        provider.addNurseUser(provider.nurseNames.first);
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
                                  provider.nurseNames
                                      .toList()
                                      .forEach((element) {
                                    element.name == newValue
                                        ? provider.addNurseUser(element)
                                        : null;
                                  });
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
                      controller: provider.controllerTitle,
                      label: 'Başklık',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: MyTextField(
                            controller: provider.controllerDate,
                            label: 'Tarih',
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
                      controller: provider.controllerStartTime,
                      label: 'Başlangıç',
                      icon: downwardIcon,
                    )),
                    SizedBox(width: 40),
                    Expanded(
                      child: MyTextField(
                        controller: provider.controllerendTime,
                        label: 'Bitiş',
                        icon: downwardIcon,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyTextField(
                  controller: provider.controllerDesc,
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
          SizedBox(
            height: 80,
            width: width,
            child: Container(
              child: TextButton(
                onPressed: () async {
                  Appointment appointment = Appointment(
                      title: provider.controllerTitle.text,
                      desc: provider.controllerDesc.text,
                      user: provider.nurse,
                      date: provider.controllerDate.text,
                      startTime: provider.controllerStartTime.text,
                      endTime: provider.controllerendTime.text,
                      diseases: provider.disaseList,
                      phone: patient.phone);
                  provider.addProgress(appointment);

                  await FirebaseDocName().addTask(
                      appointment: appointment, phoneNumber: patient.phone);
                  print("success task");
                },
                child: Text(
                  'İstek Gönder',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: width - 40,
              decoration: BoxDecoration(
                color: LightColors.kBlue,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
