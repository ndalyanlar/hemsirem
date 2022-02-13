import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hemsirem/Constant/page_names.dart';
import 'package:hemsirem/Core/calender_page_model_view.dart';
import 'package:hemsirem/Theme/colors/light_colors.dart';

import 'package:intl/intl.dart';

import '../Model/user.dart';
import '../dates_list.dart';
import '../Theme/colors/light_colors.dart';
import '../widgets/back_button.dart';
import '../Widgets/calendar_dates.dart';
import '../widgets/task_container.dart';
import 'create_new_task_page.dart';

final pageProvider = ChangeNotifierProvider(((ref) => CalenderPageModel()));

class CalendarPage extends ConsumerWidget {
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(pageProvider);
    List<Expanded> pages = List.generate(
        days.length,
        (index) => (index % 3) == 0
            ? buildPage()
            : (index % 2) == 0
                ? buildPage1()
                : buildPage2());
    final arg = ModalRoute.of(context)!.settings.arguments as MyUser;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: LightColors.kLightYellow,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          0,
        ),
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Bugün',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    height: 40.0,
                    width: 120,
                    decoration: BoxDecoration(
                      color: LightColors.kGreen,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PageNames.kCreateTaskScreenName,
                            arguments: arg);
                      },
                      child: Center(
                        child: Text('Randevu ara',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: LightColors.kLightWhite)),
                      ),
                    ),
                  ),
                ]),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('dd').format(DateTime.now()).toString(),
                style: TextStyle(
                  fontSize: 35.0,
                  color: LightColors.kDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Şubat, 2022',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 58.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      provider.changePage(index);
                    },
                    child: CalendarDates(
                      index: index,
                      day: days[index],
                      date: dates[index],
                      dayColor: index == provider.index
                          ? LightColors.kRed
                          : Colors.black54,
                      dateColor: index == provider.index
                          ? LightColors.kRed
                          : LightColors.kDarkBlue,
                    ),
                  );
                },
              ),
            ),
            pages[provider.index],
          ],
        ),
      ),
    );
  }

  Expanded buildPage() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: time.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${time[index]}:00',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    _dashedText(),
                    TaskContainer(
                      title: 'Sağlık Kontrolü',
                      subtitle: 'Baş Ağrısı, Ateş',
                      boxColor: LightColors.kLightYellow2,
                    ),
                    _dashedText(),
                    TaskContainer(
                      title: 'Serum',
                      subtitle: 'Hastanın serum yemesi',
                      boxColor: LightColors.kLavender,
                    ),
                    TaskContainer(
                      title: 'Covid-19 Aşısı',
                      subtitle: 'Biontech yoksa Sinovac aşısı.',
                      boxColor: LightColors.kPalePink,
                    ),
                    TaskContainer(
                      title: 'Tansiyon Kontrol',
                      subtitle: 'Günlük tansiyon kontrolünün yapılması',
                      boxColor: LightColors.kLightGreen,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildPage1() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: time.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${time[index]}:00',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    TaskContainer(
                      title: 'Covid-19 Aşısı',
                      subtitle: 'Biontech yoksa Sinovac aşısı.',
                      boxColor: LightColors.kPalePink,
                    ),
                    _dashedText(),
                    TaskContainer(
                      title: 'Serum',
                      subtitle: 'Hastanın serum yemesi',
                      boxColor: LightColors.kLavender,
                    ),
                    TaskContainer(
                      title: 'Sağlık Kontrolü',
                      subtitle: 'Baş Ağrısı, Ateş',
                      boxColor: LightColors.kLightYellow2,
                    ),
                    _dashedText(),
                    TaskContainer(
                      title: 'Tansiyon Kontrol',
                      subtitle: 'Günlük tansiyon kontrolünün yapılması',
                      boxColor: LightColors.kLightGreen,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildPage2() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: time.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${time[index]}:00',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    TaskContainer(
                      title: 'Sağlık Kontrolü',
                      subtitle: 'Baş Ağrısı, Ateş',
                      boxColor: LightColors.kLightYellow2,
                    ),
                    TaskContainer(
                      title: 'Covid-19 Aşısı',
                      subtitle: 'Biontech yoksa Sinovac aşısı.',
                      boxColor: LightColors.kPalePink,
                    ),
                    _dashedText(),
                    TaskContainer(
                      title: 'Serum',
                      subtitle: 'Hastanın serum yemesi',
                      boxColor: LightColors.kLavender,
                    ),
                    _dashedText(),
                    TaskContainer(
                      title: 'Tansiyon Kontrol',
                      subtitle: 'Günlük tansiyon kontrolünün yapılması',
                      boxColor: LightColors.kLightGreen,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
