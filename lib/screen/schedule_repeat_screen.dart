import 'package:flutter/material.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:score_system/screen/schedule_repeat_spec_screen.dart';
import '../util/date_util.dart';

class ScheduleRepeatPage extends StatelessWidget {
  
  static final String ROUTE_NAME = '/schedule_repeat';
  final int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              'TaskScheduleScreen.Repeat'.tr(),
              style:
              TextStyle(fontSize: 24,
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
            ),
          ),
        ),
        bottomNavigationBar: MainBottomNavigationBar(context, _selectedIndex),
        body:
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10, bottom: 5),
                height: MediaQuery.of(context).size.height / 10,
                child:
                  GestureDetector(
                      child: Container(
                        child:
                          Text(
                            " > " + SCHEDULE_REPEAT.ONCE.name,
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          ),
                      ),
                      onTap: () {_selectRepeatOption(context, SCHEDULE_REPEAT.ONCE);},
                  ),
              ),
              ... SCHEDULE_REPEAT.values.skip(1).toList()
                  .map((repeatOption) =>
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      height: MediaQuery.of(context).size.height / 10,
                      child:
                        GestureDetector(
                          child: Container(
                            child:
                            Text(
                              " > " + repeatOption.name,
                              style: TextStyle(fontSize: 24, color: Colors.blue),
                            ),
                          ),
                          onTap: () {_selectRepeatOption(context, repeatOption);},
                      ),
                    ),
              )
            ],
          )
    );
  }

  _selectRepeatOption(BuildContext context, SCHEDULE_REPEAT repeatOption) {
    if (repeatOption != SCHEDULE_REPEAT.SPECIAL) {
      return Navigator.pop(context, repeatOption);
    } else {
      Navigator.pushNamed(
        context,
        ScheduleRepeatSpecPage.ROUTE_NAME,
      );
    }
  }

}