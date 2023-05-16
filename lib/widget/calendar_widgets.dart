import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calendar_cubit.dart';
import '../model/item_list.dart';
import '../util/date_util.dart';
import '../vocabulary/constant.dart';

class CalendarDaysWidget extends StatelessWidget {
  static const DRAG_DENSITY = 1;

  final SPEC_FREQ _type;

  CalendarDaysWidget(this._type);

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<CalendarCubit, Map<SPEC_FREQ, List<DateTimeNameColor>>>(
        builder: (context, state) =>
          AnimatedSwitcher(
              duration: Duration(milliseconds: 700),
              switchInCurve: Curves.bounceIn,
              switchOutCurve: Curves.bounceOut,
              child:
              SizedBox(
                  height: 270,
                  width: 300,
                  child:
                  Column(
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          state[_type]![0].getName(),
                          style: TextStyle(fontSize: 12, color: state[_type]![0].getColor()),
                        ),
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          state[_type]![1].getName(),
                          style: TextStyle(fontSize: 12, color: state[_type]![1].getColor()),
                        ),
                      ),
                      GestureDetector(
                        child:
                        Container(
                          height: 70,
                          alignment: Alignment.center,
                          decoration:
                            BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                bottom: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                right: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              ),
                            ),
                          child: Text(
                            state[_type]![LIST_HALF_SCREEN_ACTIVE_INDEX].getName(),
                            style: TextStyle(
                              fontSize: 20,
                              color: state[_type]![LIST_HALF_SCREEN_ACTIVE_INDEX].getColor(),
                            ),
                          ),
                        ),
                        onPanUpdate: (details) {
                          if (details.delta.dx > DRAG_DENSITY || details.delta.dy > DRAG_DENSITY)
                            switch (_type) {
                              case SPEC_FREQ.WEEK:
                              case SPEC_FREQ.MONTH:
                              case SPEC_FREQ.YEAR:
                                break;
                              case SPEC_FREQ.MIN:
                                context.read<CalendarCubit>().upMin();
                                break;
                              case SPEC_FREQ.HOUR:
                                context.read<CalendarCubit>().upHour();
                                break;
                              case SPEC_FREQ.DAY:
                                context.read<CalendarCubit>().upDay();
                                break;
                            }
                          if (details.delta.dx < -DRAG_DENSITY || details.delta.dy < -DRAG_DENSITY)
                            switch (_type) {
                              case SPEC_FREQ.WEEK:
                              case SPEC_FREQ.MONTH:
                              case SPEC_FREQ.YEAR:
                                break;
                              case SPEC_FREQ.MIN:
                                context.read<CalendarCubit>().downMin();
                                break;
                              case SPEC_FREQ.HOUR:
                                context.read<CalendarCubit>().downHour();
                                break;
                              case SPEC_FREQ.DAY:
                                context.read<CalendarCubit>().downDay();
                                break;
                            }
                        },
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          state[_type]![3].getName(),
                          style: TextStyle(fontSize: 12, color: state[_type]![3].getColor()),
                        ),
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          state[_type]![4].getName(),
                          style: TextStyle(fontSize: 12, color: state[_type]![4].getColor()),
                        ),
                      ),
                    ],
                  )
              )
          )
    );
  }
}

class DayHourMinWidget extends StatelessWidget {
  static const DRAG_DENSITY = 1;

  final SPEC_FREQ _type;

  DayHourMinWidget(this._type);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayHourMinCubit, Map<SPEC_FREQ, List<DayHourMinNameColor>>>(
        builder: (context, state) =>
            SizedBox(
                height: 270,
                width: 300,
                child:
                Column(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        int.parse(state[_type]![0].getName()) < 0 ? '' : state[_type]![0].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![0].getColor()),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        int.parse(state[_type]![1].getName()) < 0 ? '' : state[_type]![1].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![1].getColor()),
                      ),
                    ),
                    GestureDetector(
                      child:
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration:
                          BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              bottom: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              right: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                            ),
                          ),
                        child: Text(
                            int.parse(state[_type]![LIST_HALF_SCREEN_ACTIVE_INDEX].getName()) < 0 ? '' : state[_type]![LIST_HALF_SCREEN_ACTIVE_INDEX].getName(),
                          style: TextStyle(
                            fontSize: 20,
                            color: state[_type]![LIST_HALF_SCREEN_ACTIVE_INDEX].getColor(),
                          ),
                        ),
                      ),
                      onPanUpdate: (details) {
                        if (details.delta.dx > DRAG_DENSITY || details.delta.dy > DRAG_DENSITY)
                          switch (_type) {
                            case SPEC_FREQ.WEEK:
                            case SPEC_FREQ.MONTH:
                            case SPEC_FREQ.YEAR:
                              break;
                            case SPEC_FREQ.MIN:
                              context.read<DayHourMinCubit>().upMin();
                              break;
                            case SPEC_FREQ.HOUR:
                              context.read<DayHourMinCubit>().upHour();
                              break;
                            case SPEC_FREQ.DAY:
                              context.read<DayHourMinCubit>().upDay();
                              break;
                          }
                        if (details.delta.dx < -DRAG_DENSITY || details.delta.dy < -DRAG_DENSITY)
                            switch (_type) {
                              case SPEC_FREQ.WEEK:
                              case SPEC_FREQ.MONTH:
                              case SPEC_FREQ.YEAR:
                                break;
                              case SPEC_FREQ.MIN:
                                context.read<DayHourMinCubit>().downMin();
                                break;
                              case SPEC_FREQ.HOUR:
                                context.read<DayHourMinCubit>().downHour();
                                break;
                              case SPEC_FREQ.DAY:
                                context.read<DayHourMinCubit>().downDay();
                                break;
                            }
                      },
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                          int.parse(state[_type]![3].getName()) < 0 ? '' : state[_type]![3].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![3].getColor()),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        int.parse(state[_type]![4].getName()) < 0 ? '' : state[_type]![4].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![4].getColor()),
                      ),
                    ),
                  ],
                )
            )
    );
  }
}

class SpecFrequencyWidget extends StatelessWidget {
  static const DRAG_DENSITY = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecFrequencyCubit, List<SpecFrequencyNameColor>> (
        builder: (context, state) =>
            SizedBox(
                height: 270,
                width: 300,
                child:
                Column(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        state[0].getName(),
                        style: TextStyle(fontSize: 12, color: state[0].getColor()),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        state[1].getName(),
                        style: TextStyle(fontSize: 12, color: state[1].getColor()),
                      ),
                    ),
                    GestureDetector(
                      child:
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration:
                          BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              bottom: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              right: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                            ),
                          ),
                        child: Text(
                            state[LIST_HALF_SCREEN_ACTIVE_INDEX].getName(),
                          style: TextStyle(
                            fontSize: 20,
                            color: state[LIST_HALF_SCREEN_ACTIVE_INDEX].getColor(),
                          ),
                        ),
                      ),
                      onPanUpdate: (details) {
                        if (details.delta.dx > DRAG_DENSITY || details.delta.dy > DRAG_DENSITY)
                            context.read<SpecFrequencyCubit>().upFrequency();
                        if (details.delta.dx < -DRAG_DENSITY || details.delta.dy < -DRAG_DENSITY)
                            context.read<SpecFrequencyCubit>().downFrequency();
                      },
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                          state[3].getName(),
                        style: TextStyle(fontSize: 12, color: state[3].getColor()),
                      ),
                    ),
                  ],
                )
            )
    );
  }

  List<SpecFrequencyNameColor> getWidgetFrequencyList(SpecFrequency frequencySrc) {
    SpecFrequency frequencyMin = frequencySrc.substract(LIST_HALF_SCREEN_ACTIVE_INDEX);
    List<SpecFrequencyNameColor> rez = [SpecFrequencyNameColor(frequencyMin, frequencyMin.specFreq.name, SCREEN_INACTIVE_COLOR)];
    MaterialColor currentColor = SCREEN_INACTIVE_COLOR;
    for (var i = 1; i < LIST_HALF_SCREEN_INDEX_LEN - 1; i++) {
      if (i == LIST_HALF_SCREEN_ACTIVE_INDEX) {
        currentColor = SCREEN_ACTIVE_COLOR;
      } else {
        currentColor = SCREEN_INACTIVE_COLOR;
      }
      SpecFrequency frequencyCurrent = frequencyMin.add(i);
      rez.add(SpecFrequencyNameColor(frequencyCurrent, frequencyCurrent.specFreq.name, currentColor));
    }
    return rez;
  }

}

class SpecIntervalWidget extends StatelessWidget {
  static const DRAG_DENSITY = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecIntervalCubit, List<SpecIntervalNameColor>> (
        builder: (context, state) =>
            SizedBox(
                height: 270,
                width: 300,
                child:
                  Column(
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          state[0].getName(),
                          style: TextStyle(fontSize: 12, color: state[0].getColor()),
                        ),
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          state[1].getName(),
                          style: TextStyle(fontSize: 12, color: state[1].getColor()),
                        ),
                      ),
                      GestureDetector(
                        child:
                        Container(
                          height: 70,
                          alignment: Alignment.center,
                          decoration:
                            BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                bottom: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                right: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              ),
                            ),
                          child: Text(
                              state[LIST_HALF_SCREEN_ACTIVE_INDEX].getName(),
                            style: TextStyle(
                              fontSize: 20,
                              color: state[LIST_HALF_SCREEN_ACTIVE_INDEX].getColor(),
                            ),
                          ),
                        ),
                        onPanUpdate: (details) {
                          if (details.delta.dx > DRAG_DENSITY || details.delta.dy > DRAG_DENSITY)
                              context.read<SpecIntervalCubit>().up();
                          if (details.delta.dx < -DRAG_DENSITY || details.delta.dy < -DRAG_DENSITY)
                              context.read<SpecIntervalCubit>().down();
                        },
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            state[3].getName(),
                          style: TextStyle(fontSize: 12, color: state[3].getColor()),
                        ),
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          state[4].getName(),
                          style: TextStyle(fontSize: 12, color: state[4].getColor()),
                        ),
                      ),
                    ],
                  )
            )
    );
  }
}

class WeekDayWidget extends StatelessWidget {
  
  Set<WEEK> _weekDaysChosen = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * CONTAINER_WIDTH_KOEF,
            child:
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 5),
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height / 20,
                    child:
                    Text(
                      'TaskScheduleScreen.PeriodReproduction'.tr(),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    child:
                    BlocBuilder<WeekDayCubit, Set<WEEK>>(
                      builder: (context, state) =>
                          GridView.count(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            children:
                            WEEK.values.where((week) => week != WEEK.ALL_WEEK && week != WEEK.WEEKDAYS && week != WEEK.WEEKENDS)
                                .map((weekDay) =>
                                InkWell(
                                  onTap: () {
                                    if (_weekDaysChosen.contains(weekDay)) {
                                      _weekDaysChosen.remove(weekDay);
                                    } else {
                                      _weekDaysChosen.add(weekDay);
                                    }
                                    context.read<WeekDayCubit>().change(_weekDaysChosen);
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                      color: _weekDaysChosen.contains(weekDay) ? Colors.blue : Colors.grey[100],
                                      border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(15),
                                    child:
                                    Text(
                                      weekDay.name,
                                      style: TextStyle(fontSize: 16,
                                          color: _weekDaysChosen.contains(weekDay) ? Colors.white : Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ).toList(),
                          ),
                    ),
                  ),
                ],
          ),
        ),
    );
  }

}

class YearMonthWidget extends StatelessWidget {

  Set<MONTH> _monthChosen = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        SizedBox(
            height: 270,
            width: 300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5, right: 20),
                  alignment: Alignment.centerLeft,
                  height: MediaQuery.of(context).size.height / 20,
                  child:
                  Text(
                    'TaskScheduleScreen.PeriodReproduction'.tr(),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child:
                  BlocBuilder<YearMonthCubit, Set<MONTH>>(
                    builder: (context, state) =>
                        GridView.count(
                          crossAxisCount: 4,
                          children:
                          MONTH.values
                              .map((month) =>
                              InkWell(
                                onTap: () {
                                  if (_monthChosen.contains(month)) {
                                    _monthChosen.remove(month);
                                  } else {
                                    _monthChosen.add(month);
                                  }
                                  context.read<YearMonthCubit>().change(_monthChosen);
                                },
                                borderRadius: BorderRadius.circular(15),
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                    color: _monthChosen.contains(month) ? Colors.blue : Colors.grey[100],
                                    border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  child:
                                  Text(
                                    month.name,
                                    style: TextStyle(fontSize: 16,
                                        color: _monthChosen.contains(month) ? Colors.white : Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ).toList(),
                        ),
                  ),
                ),
              ],
            ),
        ),
    );
  }

}

class MonthDayWidget extends StatelessWidget {
  DateTime now = DateTime.now();
  late Set<int> _monthDays;
  Set<int> _monthDaysChosen = {};
  @override
  Widget build(BuildContext context) {
    _monthDays = {for (var i = 1; i <= DateUtil.daysInMonth(now); i++) i};
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 5, right: 20),
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.height / 20,
            child:
            Text(
              'TaskScheduleScreen.ChooseDay'.tr(),
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child:
            BlocBuilder<MonthDayCubit, Set<int>>(
              builder: (context, state) =>
                  GridView.count(
                    crossAxisCount: 7,
                    children:
                    _monthDays
                        .map((day) =>
                        InkWell(
                          onTap: () {
                            if (_monthDaysChosen.contains(day)) {
                              _monthDaysChosen.remove(day);
                            } else {
                              _monthDaysChosen.add(day);
                            }
                            context.read<MonthDayCubit>().change(_monthDaysChosen);
                          },
                          borderRadius: BorderRadius.circular(15),
                          child:
                            Container(
                              decoration: BoxDecoration(
                                color: _monthDaysChosen.contains(day) ? Colors.blue : Colors.grey[100],
                                border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              child:
                              Text(
                                day.toString(),
                                style: TextStyle(fontSize: 16,
                                    color: _monthDaysChosen.contains(day) ? Colors.white : Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ),
                    ).toList(),
                  ),
            ),
          ),
        ],
      ),
    );
  }

}

class NumeralsWeekWidget extends StatelessWidget {
  static const DRAG_DENSITY = 1;

  final NUMERALS_WEEK _type;

  NumeralsWeekWidget(this._type);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumeralsWeekCubit, Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>>>(
        builder: (context, state) =>
            SizedBox(
                height: 270,
                width: 300,
                child:
                Column(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        state[_type]![0].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![0].getColor()),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        state[_type]![1].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![1].getColor()),
                      ),
                    ),
                    GestureDetector(
                      child:
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration:
                          BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              bottom: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                              right: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                            ),
                          ),
                        child: Text(
                            state[_type]![LIST_HALF_SCREEN_ACTIVE_INDEX].getName(),
                          style: TextStyle(
                            fontSize: 20,
                            color: state[_type]![LIST_HALF_SCREEN_ACTIVE_INDEX].getColor(),
                          ),
                        ),
                      ),
                      onPanUpdate: (details) {
                        if (details.delta.dx > DRAG_DENSITY || details.delta.dy > DRAG_DENSITY)
                          switch (_type) {
                            case NUMERALS_WEEK.NUMERALS:
                              context.read<NumeralsWeekCubit>().upNumeral();
                              break;
                            case NUMERALS_WEEK.WEEK:
                              context.read<NumeralsWeekCubit>().upWeek();
                              break;
                          }
                        if (details.delta.dx < -DRAG_DENSITY || details.delta.dy < -DRAG_DENSITY)
                            switch (_type) {
                              case NUMERALS_WEEK.NUMERALS:
                                context.read<NumeralsWeekCubit>().downNumerals();
                                break;
                              case NUMERALS_WEEK.WEEK:
                                context.read<NumeralsWeekCubit>().downWeek();
                                break;
                            }
                      },
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                          int.parse(state[_type]![3].getName()) < 0 ? '' : state[_type]![3].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![3].getColor()),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        int.parse(state[_type]![4].getName()) < 0 ? '' : state[_type]![4].getName(),
                        style: TextStyle(fontSize: 12, color: state[_type]![4].getColor()),
                      ),
                    ),
                  ],
                )
            )
    );
  }
}


enum DAY_WEEK {DAY, WEEK}

class MonthDayWeekSpecWidget extends StatefulWidget {

  MonthDayWeekSpecWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MonthDayWeekSpecWidget();

}

class _MonthDayWeekSpecWidget extends State<MonthDayWeekSpecWidget> {

  DAY_WEEK _option = DAY_WEEK.DAY;
  NumeralsWeek _numeralsWeek = NUMERALS_WEEK_DEFAULT;

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
    return
      Container(
        child:
          SizedBox(
            height: 270,
            width: 300,
            child:
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 5, right: 20),
                  height: MediaQuery.of(context).size.height / 20,
                  child:
                  Text(
                    'TaskScheduleScreen.PeriodReproduction'.tr(),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Divider(thickness: 1, color: Colors.grey),
                GestureDetector(
                  child:
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
                    child:
                    Text(
                      _option == DAY_WEEK.DAY ? (' > ' + 'TaskScheduleScreen.Day'.tr()) : 'TaskScheduleScreen.Day'.tr(),
                      style: TextStyle(fontSize: 24, color: _option == DAY_WEEK.DAY ? Colors.blue : Colors.black),
                    ),
                  ),
                  onTap: _chooseDay(context),
                ),
                Divider(thickness: 1, color: Colors.grey),
                GestureDetector(
                  child:
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
                    child:
                    Text(
                      _weekText(_option, _numeralsWeek),
                      style: TextStyle(fontSize: 24, color: _option == DAY_WEEK.WEEK ? Colors.blue : Colors.black),
                    ),
                  ),
                  onTap: _chooseWeek(context),
                ),
                Divider(thickness: 1, color: Colors.grey),
                if (_option == DAY_WEEK.DAY)
                  MonthDayWidget(),
              ],
            ),
          ),
      );
  }

  _chooseDay(BuildContext context) {
    setState(() {
      _option = DAY_WEEK.DAY;
    });
  }

  _chooseWeek(BuildContext context) {
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
                  Text('TaskScheduleScreen.Week'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Divider(thickness: 1, color: Colors.grey),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            NumeralsWeekWidget(NUMERALS_WEEK.NUMERALS),
                            Divider(thickness: 1, color: Colors.grey),
                            NumeralsWeekWidget(NUMERALS_WEEK.WEEK),
                          ],
                        ),
                        Divider(thickness: 1, color: Colors.grey),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<NumeralsWeekCubit, Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Cancel'.tr()),
                                      onPressed: ()
                                      {
                                        context.read<NumeralsWeekCubit>().reset(_numeralsWeek);
                                        Navigator.pop(context);
                                      },
                                    ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child:
                              BlocBuilder<NumeralsWeekCubit, Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>>>(
                                builder: (context, state) =>
                                    ElevatedButton(
                                      child: Text('Dialog.Ok'.tr()),
                                      onPressed: ()
                                      {
                                        _numeralsWeek = state[NUMERALS_WEEK.NUMERALS]![LIST_HALF_SCREEN_ACTIVE_INDEX].getNumeralsWeek();
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

  String _weekText(DAY_WEEK option, NumeralsWeek numeralsWeek) {
    String rez = option == DAY_WEEK.WEEK ? (' > ' + 'TaskScheduleScreen.Week'.tr()) : 'TaskScheduleScreen.Week'.tr();
    if (option == DAY_WEEK.WEEK) {
      rez += '(${numeralsWeek.numerals.name} ${numeralsWeek.week.name})';
    }
    return rez;
  }

}