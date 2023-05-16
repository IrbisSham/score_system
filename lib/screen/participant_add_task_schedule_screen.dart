import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_system/model/activity.dart';
import 'package:score_system/model/entity.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/screen/schedule_repeat_end_screen.dart';
import 'package:score_system/screen/schedule_repeat_screen.dart';
import 'package:score_system/util/date_util.dart';
import '../bloc/calendar_cubit.dart';
import '../current_data.dart';
import '../locator.dart';
import '../model/item_list.dart';
import '../navigation/pass_arguments.dart';
import '../vocabulary/constant.dart';
import '../vocabulary/person_data.dart';
import '../widget/calendar_widgets.dart';


int CALENDAR_ITEM_SIZE = 100;

class AddParticipantTaskSchedulePage extends StatefulWidget {

  Person? _person;
  HierarchEntity? _activity;

  static const String ROUTE_NAME = '/participant_add_task_schedule';

  AddParticipantTaskSchedulePage({super.key});

  @override
  State<StatefulWidget> createState() => _AddParticipantTaskSchedulePageState();

}

class _AddParticipantTaskSchedulePageState extends State<AddParticipantTaskSchedulePage> {
  int selectedIndex = 2;
  SCHEDULE_REPEAT _repeat = SCHEDULE_REPEAT.ONCE;
  REPEAT_END _repeatEnd = REPEAT_END.NEVER;
  String _notifications = 'TaskScheduleScreen.AtMoment'.tr();
  DayHourMin _duration = DAY_HOUR_MIN_DEFAULT;
  late DateTime _calendarStartDate;

  _AddParticipantTaskSchedulePageState(){
    _calendarStartDate = DateTime.now();
  }

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
    Object? arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      final args = arguments as PersonHierarchEntityArguments;
      widget._person = args.person;
      widget._activity = args.entity;
    }
    if (widget._person == null) {
      List<Person> persons = locator<PersonData>().getData().where((person) => person.isParticipant).toList();
      widget._person = persons.isEmpty ? CURRENT_USER : persons.first;
    }
    if (widget._activity == null) {
      widget._activity = ACTIVITY_DUMMY;
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            this.widget._person!.fio(),
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body:
        Center(
          child:
            Container(
              width: MediaQuery.of(context).size.width * CONTAINER_WIDTH_KOEF,
              height: MediaQuery.of(context).size.height * CONTAINER_WIDTH_KOEF,
              child:
                Column(
                  children:[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child:
                        Text(widget._activity!.name!),
                    ),
                    Divider(thickness: 1, color: Colors.grey),
                    GestureDetector(
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TaskScheduleScreen.DateTime'.tr()),
                            BlocBuilder<CalendarCubit, Map<SPEC_FREQ, List<DateTimeNameColor>>>(
                                builder: (context, state) =>
                                    Text(DateUtil.DATE_TIME_FORMATTER.format(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate()) + "  >",
                                        style: TextStyle(fontSize: 18, color: Colors.grey),
                                    )
                            ),
                          ],
                        ),
                      onTap: _setDateStart,
                    ),
                    Divider(thickness: 1, color: Colors.grey),
                    GestureDetector(
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TaskScheduleScreen.Duration'.tr()),
                            BlocBuilder<DayHourMinCubit, Map<SPEC_FREQ, List<DayHourMinNameColor>>>(
                                builder: (context, state) =>
                                    Text(formatDuration(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin()) + "  >",
                                      style: TextStyle(fontSize: 18, color: Colors.grey),
                                    )
                            ),
                          ],
                        ),
                      onTap: _setDuration,
                    ),
                    Divider(thickness: 1, color: Colors.grey),
                    GestureDetector(
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TaskScheduleScreen.Repeat'.tr()),
                            Text(_repeat.name + "  >"),
                          ],
                        ),
                      onTap: () {_setRepeat(context);},
                    ),
                    if (_repeat != SCHEDULE_REPEAT.ONCE)
                      GestureDetector(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Divider(thickness: 1, color: Colors.grey),
                            Text('TaskScheduleScreen.RepeatEnd'.tr()),
                            Text(_repeatEnd.name + "  >"),
                          ],
                        ),
                        onTap: () {_setRepeatEnd(context);},
                      ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    GestureDetector(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Divider(thickness: 1, color: Colors.grey),
                          Text('TaskScheduleScreen.Notifications'.tr()),
                          Text(_notifications + "  >"),
                        ],
                      ),
                      onTap: _setNotifications,
                    ),
                  ]
                ),
            ),
        ),
      bottomNavigationBar: MainBottomNavigationBar(context, selectedIndex),
    );
  }

  void _setDateStart() {
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
                  Text('TaskScheduleScreen.Start'.tr()),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  BlocBuilder<CalendarCubit, Map<SPEC_FREQ, List<DateTimeNameColor>>>(
                      builder: (context, state) =>
                          Text(DateUtil.DATE_TIME_FORMATTER.format(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate()))
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Divider(thickness: 1, color: Colors.grey),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CalendarDaysWidget(SPEC_FREQ.DAY),
                            Divider(thickness: 1, color: Colors.grey),
                            CalendarDaysWidget(SPEC_FREQ.HOUR),
                            Divider(thickness: 1, color: Colors.grey),
                            CalendarDaysWidget(SPEC_FREQ.MIN),
                          ],
                        ),
                        Divider(thickness: 1, color: Colors.grey),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<CalendarCubit, Map<SPEC_FREQ, List<DateTimeNameColor>>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Cancel'.tr()),
                                      onPressed: ()
                                      {
                                        context.read<CalendarCubit>().reset(_calendarStartDate);
                                        Navigator.pop(context);
                                      },
                                    ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<CalendarCubit, Map<SPEC_FREQ, List<DateTimeNameColor>>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Ok'.tr()),
                                      onPressed: ()
                                      {
                                        _calendarStartDate = state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate();
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

  void _setDuration() {
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
                  Text('TaskScheduleScreen.Duration'.tr()),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  BlocBuilder<DayHourMinCubit, Map<SPEC_FREQ, List<DayHourMinNameColor>>>(
                      builder: (context, state) =>
                          Text(formatDuration(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin()))
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Divider(thickness: 1, color: Colors.grey),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            DayHourMinWidget(SPEC_FREQ.DAY),
                            DayHourMinWidget(SPEC_FREQ.HOUR),
                            DayHourMinWidget(SPEC_FREQ.MIN),
                          ],
                        ),
                        Divider(thickness: 1, color: Colors.grey),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<DayHourMinCubit, Map<SPEC_FREQ, List<DayHourMinNameColor>>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Cancel'.tr()),
                                      onPressed: ()
                                      {
                                        context.read<DayHourMinCubit>().reset(_duration);
                                        Navigator.pop(context);
                                      },
                                    ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<DayHourMinCubit, Map<SPEC_FREQ, List<DayHourMinNameColor>>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Ok'.tr()),
                                      onPressed: ()
                                      {
                                        _duration = state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin();
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

  void _setNotifications() {

  }

  Future<void> _setRepeat(BuildContext context) async {
    SCHEDULE_REPEAT repeat = await Navigator.pushNamed(
      context,
      ScheduleRepeatPage.ROUTE_NAME,
    ) as SCHEDULE_REPEAT;
    setState(() {
      this._repeat = repeat;
    });
  }

  Future<void> _setRepeatEnd(BuildContext context) async {
    REPEAT_END repeatEnd = await Navigator.pushNamed(
      context,
      ScheduleRepeatEndPage.ROUTE_NAME,
    ) as REPEAT_END;
    setState(() {
      this._repeatEnd = repeatEnd;
    });
  }

}