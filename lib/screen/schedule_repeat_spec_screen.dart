import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_system/bloc/calendar_cubit.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';

import '../util/date_util.dart';
import '../vocabulary/constant.dart';
import '../widget/calendar_widgets.dart';

class ScheduleRepeatSpecPage extends StatefulWidget {

  static final String ROUTE_NAME = '/schedule_repeat_spec';

  ScheduleRepeatSpecPage({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleRepeatSpecPageState();

}

class _ScheduleRepeatSpecPageState extends State<ScheduleRepeatSpecPage> {
  CalendarSpecBox _calendarSpecBox = CalendarSpecBox.empty();
  String _result = "";
  final int _selectedIndex = 3;
  bool isShowDialog = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _result = _getResult();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              'TaskScheduleScreen.Special'.tr(),
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
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 5, right: 20),
                height: MediaQuery.of(context).size.height / 10,
                child:
                  GestureDetector(
                      child: Container(
                        child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child:
                                  Text(
                                    'TaskScheduleScreen.Frequency'.tr(),
                                    style: TextStyle(fontSize: 24, color: Colors.black),
                                  ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child:
                                  BlocBuilder<SpecFrequencyCubit, List<SpecFrequencyNameColor>>(
                                      builder: (context, state) =>
                                          Text(state[LIST_HALF_SCREEN_ACTIVE_INDEX].getName() + "  >",
                                            style: TextStyle(fontSize: 18, color: Colors.grey),
                                          )
                                  ),
                              ),
                            ],
                          )
                      ),
                      onTap: () { _selectSpecFrequencyOption(context);},
                  ),
              ),
              Divider(thickness: 1, color: Colors.grey),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 5, right: 20),
                height: MediaQuery.of(context).size.height / 10,
                child:
                  GestureDetector(
                      child: Container(
                        child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child:
                                  Text(
                                    'TaskScheduleScreen.Interval'.tr(),
                                    style: TextStyle(fontSize: 24, color: Colors.black),
                                  ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child:
                                  BlocBuilder<SpecFrequencyCubit, List<SpecFrequencyNameColor>>(
                                      builder: (context, state) =>
                                          Text(state[LIST_HALF_SCREEN_ACTIVE_INDEX].getName() + "  >",
                                            style: TextStyle(fontSize: 18, color: Colors.grey),
                                          )
                                  ),
                              ),
                            ],
                          )
                      ),
                      onTap: () {_selectIntervalOption(context);},
                  ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 5, right: 20),
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height / 20,
                child:
                Text(
                  _result,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 300),
                padding: EdgeInsets.only(left: 20, top: 5, right: 20),
                alignment: Alignment.centerLeft,
                child:
                  BlocBuilder<SpecFrequencyCubit, List<SpecFrequencyNameColor>>(
                    builder: (context, state) =>
                        _showFrequencyWidget(state[LIST_HALF_SCREEN_ACTIVE_INDEX].getFrequency().specFreq),
                  ),
              ),
            ],
          )
    );
  }

  Widget _showFrequencyWidget(SPEC_FREQ specFreq) {
    Widget retn = Container();
    if (isShowDialog == true) {
      return retn;
    }
    switch(specFreq) {
      case SPEC_FREQ.MIN:
      case SPEC_FREQ.HOUR:
      case SPEC_FREQ.DAY:
        break;
      case SPEC_FREQ.WEEK:
        retn = WeekDayWidget();
        break;
      case SPEC_FREQ.MONTH:
        retn = MonthDayWeekSpecWidget();
        break;
      case SPEC_FREQ.YEAR:
        retn = YearMonthWidget();
        break;
    }
    return retn;
  }

  // todo
  String _getResult() {
    String rez = 'TaskScheduleScreen.ActivityRepeat'.tr();
    // rez += ' ' + 'TaskScheduleScreen.Every'.tr();
    // rez += _calendarSpecBox.specInterval.pos > 1 ? ' ${_calendarSpecBox.specInterval.pos}' : "";
    // rez += ' ${_calendarSpecBox.specFrequency.specFreq.name}';
    // if (_calendarSpecBox.specItemsMonthDay.isNotEmpty) {
    //   _calendarSpecBox.specItemsMonthDay.values.first.forEach((element) {
    //     rez += ', ' + element.toString();
    //   });
    // }
    // if (_calendarSpecBox.specItemsWeek.isNotEmpty) {
    //   _calendarSpecBox.specItemsWeek.values.first.forEach((element) {
    //     rez += ', ' + element.name;
    //   });
    // }
    // if (_calendarSpecBox.specItemsMonthWeek.isNotEmpty) {
    //   _calendarSpecBox.specItemsMonthWeek.values.first.forEach((element) {
    //     rez += ', ' + element.keys.first.name + ' ' + element.values.first.name;
    //   });
    // }
    // if (_calendarSpecBox.specItemsYearMonth.isNotEmpty) {
    //   _calendarSpecBox.specItemsYearMonth.values.first.forEach((element) {
    //     rez += ', ' + element.name;
    //   });
    // }
    return rez;
  }

  _selectIntervalOption(BuildContext context) {
    setState(() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
            width: MediaQuery
                .of(context)
                .size
                .width * CONTAINER_WIDTH_KOEF,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BlocBuilder<SpecIntervalCubit, List<SpecIntervalNameColor>>(
                    builder: (context, state) =>
                        Text('TaskScheduleScreen.Every'.tr() + ' ${state[LIST_HALF_SCREEN_ACTIVE_INDEX].getInterval().pos > 1 ? state[LIST_HALF_SCREEN_ACTIVE_INDEX].getInterval().pos : ""} ${_calendarSpecBox.specFrequency.specFreq.name}' ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Divider(thickness: 1, color: Colors.grey),
                  Container(
                    child: Column(
                      children: [
                        SpecIntervalWidget(),
                        Divider(thickness: 1, color: Colors.grey),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<SpecIntervalCubit, List<SpecIntervalNameColor>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Cancel'.tr()),
                                      onPressed: ()
                                      {
                                        context.read<SpecIntervalCubit>().reset(_calendarSpecBox.specInterval);
                                        isShowDialog = false;
                                        Navigator.pop(context);
                                      },
                                    ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<SpecIntervalCubit, List<SpecIntervalNameColor>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Ok'.tr()),
                                      onPressed: ()
                                      {
                                        _calendarSpecBox.specInterval = state[LIST_HALF_SCREEN_ACTIVE_INDEX].getInterval();
                                        isShowDialog = false;
                                        Navigator.pop(context);
                                      },
                                    ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  _selectSpecFrequencyOption(BuildContext context) {
    setState(() {
      isShowDialog = true;
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
            width: MediaQuery
                .of(context)
                .size
                .width * CONTAINER_WIDTH_KOEF,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('TaskScheduleScreen.Frequency'.tr()),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Divider(thickness: 1, color: Colors.grey),
                  Container(
                    child: Column(
                      children: [
                        SpecFrequencyWidget(),
                        Divider(thickness: 1, color: Colors.grey),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<SpecFrequencyCubit, List<SpecFrequencyNameColor>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Cancel'.tr()),
                                      onPressed: ()
                                      {
                                        isShowDialog = false;
                                        context.read<SpecFrequencyCubit>().reset(_calendarSpecBox.specFrequency);
                                        Navigator.pop(context);
                                      },
                                    ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<SpecFrequencyCubit, List<SpecFrequencyNameColor>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Ok'.tr()),
                                      onPressed: ()
                                      {
                                        isShowDialog = false;
                                        _calendarSpecBox.specFrequency = state[LIST_HALF_SCREEN_ACTIVE_INDEX].getFrequency();
                                        Navigator.pop(context);
                                      },
                                    ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

}