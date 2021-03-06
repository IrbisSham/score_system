import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:score_system/main.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/screen/participant_tasks_screen.dart';
import 'package:score_system/service/person_service.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/constant.dart';

class ParticipantsPage extends StatefulWidget {
  static final String ROUTE_NAME = '/participants';

  ParticipantsPage();

  @override
  State<StatefulWidget> createState() {
    return ParticipantsPageState();
  }

}

class ParticipantsPageState extends State<ParticipantsPage> {
  final String participantsTitle = "Участники";
  int selectedIndex = 0;

  late DateFormat dateFormat;
  late DateFormat timeFormat;
  late final DateTime _dtBeg;
  late final DateTime _dtEnd;


  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat.yMMMMd('ru');
    timeFormat = new DateFormat.Hms('ru');
    final DateTime now = DateTime.now();
    _dtBeg = DateTime(now.year, now.month, now.day);
    _dtEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            participantsTitle,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(context, selectedIndex),
      body:
      // LayoutBuilder(
      //     builder: (BuildContext context, BoxConstraints viewportConstraints) {
      //       return
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child:
                  Container(child:
                    Column(
                      children: [
                        Text(getIt<DateUtil>().getDateNowInStr(), style: TextStyle(fontSize: 18)),
                      ]
                    ),
                  )
            ),
            Expanded(child:
              ListView(
                children:
                  getIt<PersonService>().getPersonProgress(null, _dtBeg, _dtEnd).values.map(
                        (personProgress) =>
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width,
                          // height: 200,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                // alignment: Alignment.center,
                                child:
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ParticipantTasksPage.ROUTE_NAME,
                                      arguments: ParticipantTasksArguments(
                                        personProgress.person,
                                        _dtBeg,
                                        _dtEnd
                                      ),
                                    );
                                  },
                                  child:
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child:
                                          personProgress.person.avaPath != null
                                            ?
                                          Image.asset(
                                            personProgress.person.avaPath!,
                                          )
                                            :
                                          Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
                                      ),
                                      radius: 52,
                                    ),
                                ),
                                // padding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                // alignment: Alignment.center,
                                // padding: EdgeInsets.only(bottom: 25, left: 20, right: 20),
                                  child: Column(
                                      children: [
                                        Container(
                                          // padding: EdgeInsets.only(left: 30),
                                          alignment: Alignment.center,
                                          child:
                                            Text(
                                              personProgress.person.nickName,
                                              style: TextStyle(
                                                fontSize: 26,
                                                color: Theme.of(context).colorScheme.primary,
                                                fontFamily: FONT_FAMILY_SECOND,
                                              ),
                                            ),
                                        ),
                                        Container(
                                          // padding: EdgeInsets.only(left: 30),
                                          alignment: Alignment.center,
                                          child:
                                            personProgress == null ? Text("Нет данных") :
                                            Text(
                                              "Всего баллов: ${personProgress.sumAll}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context).colorScheme.secondary,
                                                fontFamily: FONT_FAMILY_SECOND,
                                              ),
                                            ),
                                        ),
                                        Container(
                                          // padding: EdgeInsets.only(left: 30),
                                          alignment: Alignment.center,
                                          child:
                                            personProgress == null ? Text("Нет данных") :
                                            Text(
                                              "Сегодня: ${personProgress.sumLocal}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context).colorScheme.secondary,
                                                fontFamily: FONT_FAMILY_SECOND,
                                              ),
                                            ),
                                        ),
                                      ],
                                    )
                              ),
                            ],
                          ),
                        )
                ).toList()
              )
            ),
          ]
        )
    );
  }

  // Widget _switchDate(bool isShowAll) {
  //   Widget widget;
  //   if (isShowAll) {
  //
  //   } else {
  //
  //   }
  // }

}