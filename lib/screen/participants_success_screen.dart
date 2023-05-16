import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/service/person_service.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/constant.dart';

import '../current_data.dart';
import '../locator.dart';
import '../navigation/pass_arguments.dart';
import '../widget/person_avatar.dart';

class ParticipantSuccessPage extends StatelessWidget {

  static const String ROUTE_NAME = '/participants/success';

  final String successTitle = 'ParticipantsSuccess.Title'.tr();
  final int selectedIndex = 1;

  late final DateTime _dtBeg;
  late final DateTime _dtEnd;

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null) {
      arguments = PersonDatesIntervalArguments(
          CURRENT_USER,
          DATE_TIME_MIN,
          DATE_TIME_MAX
      );
    }
    final args = arguments as PersonDatesIntervalArguments;
    _dtBeg = args.dtBeg;
    _dtEnd = args.dtEnd;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            successTitle,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
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
                                              padding: EdgeInsets.only(bottom: 10, top: 10),
                                              alignment: Alignment.center,
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.primary,
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Text(
                                                        'ParticipantsSuccess.TasksComplete'.tr(),
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontFamily: FONT_FAMILY_SECOND,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child:
                                                        Text(
                                                          '${personPrizeStat.taskComplete}',
                                                          style: TextStyle(
                                                            fontSize: 26,
                                                            fontFamily: FONT_FAMILY_SECOND,
                                                          ),
                                                        ),
                                                      padding: EdgeInsets.only(right: 10),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(bottom: 10, top: 10),
                                              alignment: Alignment.center,
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(bottom: 10),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.primary,
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child:
                                                        Text(
                                                          'ParticipantsSuccess.ScoreTaken'.tr(),
                                                          style: TextStyle(
                                                            fontSize: 26,
                                                            fontFamily: FONT_FAMILY_SECOND,
                                                          ),
                                                        ),
                                                    ),
                                                    Container(
                                                      child:
                                                      Text(
                                                        '${personPrizeStat.score}',
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontFamily: FONT_FAMILY_SECOND,
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(right: 10),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(bottom: 10, top: 10),
                                              alignment: Alignment.center,
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(bottom: 10),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.primary,
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child:
                                                      Text(
                                                        'ParticipantsSuccess.ChoosePrizes'.tr(),
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontFamily: FONT_FAMILY_SECOND,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child:
                                                      Text(
                                                        '${personPrizeStat.prizeChoose}',
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontFamily: FONT_FAMILY_SECOND,
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(right: 10),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(bottom: 10, top: 10),
                                              alignment: Alignment.center,
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(bottom: 10),
                                                alignment: Alignment.center,
                                                color: Theme.of(context).colorScheme.primary,
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child:
                                                      Text(
                                                        'ParticipantsSuccess.GetPrizes'.tr(),
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontFamily: FONT_FAMILY_SECOND,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child:
                                                      Text(
                                                        '${personPrizeStat.prizeGet}',
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontFamily: FONT_FAMILY_SECOND,
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(right: 10),
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
                                color: Theme.of(context).colorScheme.primary,
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