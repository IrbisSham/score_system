import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/service/person_service.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/constant.dart';

import '../locator.dart';
import '../navigation/pass_arguments.dart';
import '../widget/person_avatar.dart';

class ParticipantPrizePage extends StatelessWidget {

  static final String ROUTE_NAME = '/participants/prize';

  final String successTitle = "Успехи";
  int selectedIndex = 0;

  late final DateTime _dtBeg;
  late final DateTime _dtEnd;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PersonDatesIntervalArguments;
    _dtBeg = args.dtBeg;
    _dtEnd = args.dtEnd;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            successTitle,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(context, selectedIndex),
      body:
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
                  locator<PersonService>().getPersonPrizeStat(null, _dtBeg, _dtEnd).values.map(
                        (personPrizeStat) =>
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width,
                          // height: 200,
                          child:
                            Column(children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AvatarInList(personPrizeStat.person, _dtBeg, _dtEnd),
                                  Container(
                                      width: MediaQuery.of(context).size.width / 3,
                                      // alignment: Alignment.center,
                                      // padding: EdgeInsets.only(bottom: 25, left: 20, right: 20),
                                      child:
                                        Column(
                                          children: [
                                            Container(
                                              // padding: EdgeInsets.only(left: 30),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.secondary,
                                                child:
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Выполнено заданий',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${personPrizeStat.taskComplete}',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(left: 30),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.secondary,
                                                child:
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Набрано балов',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${personPrizeStat.score}',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(left: 30),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.secondary,
                                                child:
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Выбрано наград',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${personPrizeStat.prizeChoose}',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(left: 30),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.secondary,
                                                child:
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Получено наград',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${personPrizeStat.prizeGet}',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        fontFamily: FONT_FAMILY_SECOND,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ],
                                      )
                                  ),
                                ],
                              ),
                              Container(
                                color: Theme.of(context).colorScheme.secondary,
                                height: 2,
                              )
                            ],)
                        )
                ).toList()
              )
            ),
          ]
        )
    );
  }

}