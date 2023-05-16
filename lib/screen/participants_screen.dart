import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/service/person_service.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/constant.dart';

import '../current_data.dart';
import '../locator.dart';
import '../widget/person_avatar.dart';

class ParticipantsPage extends StatefulWidget {
  static final String ROUTE_NAME = '/participants';

  ParticipantsPage();

  @override
  State<StatefulWidget> createState() {
    return ParticipantsPageState();
  }

}

class ParticipantsPageState extends State<ParticipantsPage> {
  final String _participantsTitle = 'ParticipantsScreen.Participants'.tr();
  int _selectedIndex = 0;

  late final DateTime _dtBeg;
  late final DateTime _dtEnd;


  @override
  void initState() {
    super.initState();
    _dtBeg = CURRENT_DATA_MIN;
    _dtEnd = CURRENT_DATA_MAX;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            _participantsTitle,
            style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(context, _selectedIndex),
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
                        Text(locator<DateUtil>().getDateNowInStr(), style: TextStyle(fontSize: 18)),
                      ]
                    ),
                  )
            ),
            Expanded(child:
              ListView(
                children:
                  locator<PersonService>().getPersonProgress(null, _dtBeg, _dtEnd).values.map(
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
                              AvatarInList(personProgress.person, _dtBeg, _dtEnd),
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
                                            Text(
                                              "${'ParticipantsScreen.TotalScore'.tr()} ${personProgress.sumAll}",
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
                                            Text(
                                              "${'Today'.tr()}: ${personProgress.sumLocal}",
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

}