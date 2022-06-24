import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:score_system/component/pie_diagram.dart';
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

  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat.yMMMMd('ru');
    timeFormat = new DateFormat.Hms('ru');
    bool _isShowAll = false;
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
                  getIt<PersonService>().getAllPersonProgressGroupByPerson().map(
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
                                  child: Container(
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
                                  )
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: TaskStatPie(
                                  dataMap: {
                                    "Успешно" : personProgress.successProgress as double,
                                    "Осталось" : (personProgress.allProgress - personProgress.successProgress) as double
                                  },
                                  title: "${personProgress.successProgress} из ${personProgress.allProgress}",
                                  colorList: taskPieColorList
                                ),
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