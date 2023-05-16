import 'package:flutter/material.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import '../util/date_util.dart';

class ScheduleRepeatEndPage extends StatelessWidget {

  static final String ROUTE_NAME = '/schedule_repeat_end';
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
              'TaskScheduleScreen.RepeatEnd'.tr(),
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
                padding: EdgeInsets.only(top: 10, bottom: 5),
                height: MediaQuery.of(context).size.height / 20,
                child:
                  GestureDetector(
                      child: Container(
                        child:
                          Text(
                            " > " + REPEAT_END.NEVER.name,
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          ),
                      ),
                      onTap: _selectRepeatEndOption(context, REPEAT_END.NEVER),
                  ),
              ),
              ... REPEAT_END.values.skip(1).toList()
                  .map((repeatOption) =>
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      height: MediaQuery.of(context).size.height / 20,
                      child:
                        GestureDetector(
                          child: Container(
                            child:
                            Text(
                              " > " + repeatOption.name,
                              style: TextStyle(fontSize: 24, color: Colors.blue),
                            ),
                          ),
                          onTap: _selectRepeatEndOption(context, repeatOption),
                      ),
                    ),
              )
            ],
          )
    );
  }

  _selectRepeatEndOption(BuildContext context, REPEAT_END repeatOption) {
    Navigator.pop(context, repeatOption);
  }

}