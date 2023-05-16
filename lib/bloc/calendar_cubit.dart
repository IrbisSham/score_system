import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/item_list.dart';
import '../util/date_util.dart';
import '../vocabulary/constant.dart';

class CalendarCubit extends Cubit<Map<SPEC_FREQ, List<DateTimeNameColor>>> {
  CalendarCubit() : super(getAllWidgetCalendarList(DateTime.now()));
  void reset(DateTime dateTime) {
    emit(getAllWidgetCalendarList(dateTime));
  }
  void upDay() {
    emit(getAllWidgetCalendarList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate().add(Duration(days: 1))));
  }
  void downDay() {
    emit(getAllWidgetCalendarList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate().subtract(Duration(days: 1))));
  }
  void upHour() {
    emit(getAllWidgetCalendarList(state[SPEC_FREQ.HOUR]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate().add(Duration(hours: 1))));
  }
  void downHour() {
    emit(getAllWidgetCalendarList(state[SPEC_FREQ.HOUR]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate().subtract(Duration(hours: 1))));
  }
  void upMin() {
    emit(getAllWidgetCalendarList(state[SPEC_FREQ.MIN]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate().add(Duration(minutes: 1))));
  }
  void downMin() {
    emit(getAllWidgetCalendarList(state[SPEC_FREQ.MIN]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDate().subtract(Duration(minutes: 1))));
  }
}

Map<SPEC_FREQ, List<DateTimeNameColor>> getAllWidgetCalendarList(DateTime dateTimeCurrent) {
  Map<SPEC_FREQ, List<DateTimeNameColor>> rezult = {};
  SPEC_FREQ type = SPEC_FREQ.MIN;
  Map<SPEC_FREQ, List<DateTimeNameColor>> rez = getWidgetCalendarList(dateTimeCurrent, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  type = SPEC_FREQ.HOUR;
  rez = getWidgetCalendarList(dateTimeCurrent, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  type = SPEC_FREQ.DAY;
  rez = getWidgetCalendarList(dateTimeCurrent, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  return rezult;
}

Map<SPEC_FREQ, List<DateTimeNameColor>> getWidgetCalendarList(DateTime dateTimeCurrent, SPEC_FREQ type) {
  Map<SPEC_FREQ, List<DateTimeNameColor>> rezult = {};
  late Duration duration;
  late DateFormat dateFormat;
  switch (type) {
    case SPEC_FREQ.WEEK:
    case SPEC_FREQ.MONTH:
    case SPEC_FREQ.YEAR:
      break;
    case SPEC_FREQ.MIN:
      duration = Duration(minutes: LIST_HALF_SCREEN_ACTIVE_INDEX);
      dateFormat = DateUtil.CALENDAR_MIN_FORMATTER;
      break;
    case SPEC_FREQ.HOUR:
      duration = Duration(hours: LIST_HALF_SCREEN_ACTIVE_INDEX);
      dateFormat = DateUtil.CALENDAR_HOURS_FORMATTER;
      break;
    case SPEC_FREQ.DAY:
      duration = Duration(days: LIST_HALF_SCREEN_ACTIVE_INDEX);
      dateFormat = DateUtil.CALENDAR_DAY_FORMATTER;
  }
  DateTime dateTimeMin = dateTimeCurrent.subtract(duration);
  List<DateTimeNameColor> rez = [DateTimeNameColor(dateTimeMin, dateFormat.format(dateTimeMin), SCREEN_INACTIVE_COLOR)];
  MaterialColor currentColor = SCREEN_INACTIVE_COLOR;
  for (var i = 1; i < LIST_HALF_SCREEN_INDEX_LEN; i++) {
    if (i == LIST_HALF_SCREEN_ACTIVE_INDEX) {
      currentColor = SCREEN_ACTIVE_COLOR;
    } else {
      currentColor = SCREEN_INACTIVE_COLOR;
    }
    switch (type) {
      case SPEC_FREQ.WEEK:
      case SPEC_FREQ.MONTH:
      case SPEC_FREQ.YEAR:
        break;
      case SPEC_FREQ.MIN:
        duration = Duration(minutes: i);
        break;
      case SPEC_FREQ.HOUR:
        duration = Duration(hours: i);
        break;
      case SPEC_FREQ.DAY:
        duration = Duration(days: i);
        break;
    }
    DateTime curDate = dateTimeMin.add(duration);
    rez.add(DateTimeNameColor(curDate, dateFormat.format(curDate), currentColor));
  }
  rezult[type] = rez;
  return rezult;
}

class DayHourMinNameColor {

  DayHourMinNameColor(this._dayHourMin, this._name, this._color);

  DayHourMin _dayHourMin;
  String _name;
  Color _color;

  String getName() {
    return _name;
  }

  DayHourMin getDayHourMin() {
    return _dayHourMin;
  }

  Color getColor() {
    return _color;
  }
}

class NumeralsWeekNameColor {

  NumeralsWeekNameColor(this._numeralsWeek, this._name, this._color);

  NumeralsWeek _numeralsWeek;
  String _name;
  Color _color;

  String getName() {
    return _name;
  }

  NumeralsWeek getNumeralsWeek() {
    return _numeralsWeek;
  }

  Color getColor() {
    return _color;
  }
}

class SpecIntervalNameColor {

  SpecIntervalNameColor(this._interval, this._name, this._color);

  SpecInterval _interval;
  String _name;
  Color _color;

  String getName() {
    return _name;
  }

  SpecInterval getInterval() {
    return _interval;
  }

  Color getColor() {
    return _color;
  }
}

class DayHourMinCubit extends Cubit<Map<SPEC_FREQ, List<DayHourMinNameColor>>> {
  DayHourMinCubit() : super(getAllWidgetDayHourMinList(DAY_HOUR_MIN_DEFAULT));
  void reset(DayHourMin dayHourMin) {
    emit(getAllWidgetDayHourMinList(dayHourMin));
  }
  void upDay() {
    emit(getAllWidgetDayHourMinList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin().addDay(1)));
  }
  void downDay() {
    emit(getAllWidgetDayHourMinList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin().downDay(1)));
  }
  void upHour() {
    emit(getAllWidgetDayHourMinList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin().addHour(1)));
  }
  void downHour() {
    emit(getAllWidgetDayHourMinList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin().downHour(1)));
  }
  void upMin() {
    emit(getAllWidgetDayHourMinList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin().addMin(1)));
  }
  void downMin() {
    emit(getAllWidgetDayHourMinList(state[SPEC_FREQ.DAY]![LIST_HALF_SCREEN_ACTIVE_INDEX].getDayHourMin().downMin(1)));
  }
}

Map<SPEC_FREQ, List<DayHourMinNameColor>> getAllWidgetDayHourMinList(DayHourMin dayHourMin) {
  Map<SPEC_FREQ, List<DayHourMinNameColor>> rezult = {};
  SPEC_FREQ type = SPEC_FREQ.MIN;
  Map<SPEC_FREQ, List<DayHourMinNameColor>> rez = getWidgetDayHourMinList(dayHourMin, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  type = SPEC_FREQ.HOUR;
  rez = getWidgetDayHourMinList(dayHourMin, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  type = SPEC_FREQ.DAY;
  rez = getWidgetDayHourMinList(dayHourMin, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  return rezult;
}

Map<SPEC_FREQ, List<DayHourMinNameColor>> getWidgetDayHourMinList(DayHourMin dayHourMinSrc, SPEC_FREQ type) {
  Map<SPEC_FREQ, List<DayHourMinNameColor>> rezult = {};
  List<DayHourMinNameColor> rez = List.filled(LIST_HALF_SCREEN_INDEX_LEN, DayHourMinNameColor(dayHourMinSrc, "", SCREEN_INACTIVE_COLOR));
  Color currentColor;
  DayHourMin dayHourMinCurrent;
  DayHourMin dayHourMinPrev = DayHourMin(day: dayHourMinSrc.day, hour: dayHourMinSrc.hour, min: dayHourMinSrc.min);
  for (var i = LIST_HALF_SCREEN_INDEX_LEN - 1; i >= 0; i--) {
    if (i == LIST_HALF_SCREEN_ACTIVE_INDEX) {
      currentColor = SCREEN_ACTIVE_COLOR;
    } else {
      currentColor = SCREEN_INACTIVE_COLOR;
    }
    switch (type) {
      case SPEC_FREQ.WEEK:
      case SPEC_FREQ.MONTH:
      case SPEC_FREQ.YEAR:
        break;
      case SPEC_FREQ.MIN:
        dayHourMinCurrent = DayHourMin(day: dayHourMinSrc.day, hour: dayHourMinSrc.hour, min: dayHourMinSrc.min).addMin(i - LIST_HALF_SCREEN_ACTIVE_INDEX);
        rez[i] = DayHourMinNameColor(dayHourMinCurrent, (dayHourMinCurrent.min == 0 && dayHourMinPrev.min == 0) ? '' : dayHourMinCurrent.min.toString(), currentColor);
        dayHourMinPrev = dayHourMinCurrent;
        break;
      case SPEC_FREQ.HOUR:
        dayHourMinCurrent = DayHourMin(day: dayHourMinSrc.day, hour: dayHourMinSrc.hour, min: dayHourMinSrc.min).addHour(i - LIST_HALF_SCREEN_ACTIVE_INDEX);
        rez[i] = DayHourMinNameColor(dayHourMinCurrent, (dayHourMinCurrent.hour == 0 && dayHourMinPrev.hour == 0) ? '' : dayHourMinCurrent.hour.toString(), currentColor);
        dayHourMinPrev = dayHourMinCurrent;
        break;
      case SPEC_FREQ.DAY:
        dayHourMinCurrent = DayHourMin(day: dayHourMinSrc.day, hour: dayHourMinSrc.hour, min: dayHourMinSrc.min).addDay(i - LIST_HALF_SCREEN_ACTIVE_INDEX);
        rez[i] = DayHourMinNameColor(dayHourMinCurrent, (dayHourMinCurrent.day == 0 && dayHourMinPrev.day == 0) ? '' : dayHourMinCurrent.day.toString(), currentColor);
        dayHourMinPrev = dayHourMinCurrent;
        break;
    }
  }
  rezult[type] = rez;
  return rezult;
}

class WeekDayCubit extends Cubit<Set<WEEK>> {
  WeekDayCubit() : super({});
  void reset() {
    emit({});
  }
  void change(Set<WEEK> set) {
    emit(set);
  }
}

class MonthDayCubit extends Cubit<Set<int>> {
  MonthDayCubit() : super({});
  void reset() {
    emit({});
  }
  void change(Set<int> set) {
    emit(set);
  }
}

class YearMonthCubit extends Cubit<Set<MONTH>> {
  YearMonthCubit() : super({});
  void reset() {
    emit({});
  }
  void change(Set<MONTH> set) {
    emit(set);
  }
}

class CalendarSpecBox {

  SpecFrequency specFrequency;
  SpecInterval specInterval;
  Set<WEEK> weekDay;
  NumeralsWeek numeralsWeek;
  Set<int> monthDay;
  Set<MONTH> yearMonth;

  void setEmpty() {
    weekDay = {};
    yearMonth = {};
    numeralsWeek = NUMERALS_WEEK_DEFAULT;
    monthDay = {};
    specFrequency = SpecFrequency(specFreq: SPEC_FREQ.DAY);
    specInterval = SPEC_INTERVAL_DEFAULT;
  }

  CalendarSpecBox({
    required this.specFrequency,
    required this.specInterval,
    required this.weekDay,
    required this.numeralsWeek,
    required this.monthDay,
    required this.yearMonth
  });

  CalendarSpecBox.empty():
        weekDay = {},
        numeralsWeek = NUMERALS_WEEK_DEFAULT,
        monthDay = {},
        yearMonth = {},
        specFrequency = SpecFrequency(specFreq: SPEC_FREQ.DAY),
        specInterval = SPEC_INTERVAL_DEFAULT;

}

class NumeralsWeekCubit extends Cubit<Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>>> {
  NumeralsWeekCubit() : super(getAllWidgetNumeralsWeekList(NUMERALS_WEEK_DEFAULT));
  void reset(NumeralsWeek numeralsWeek) {
    emit(getAllWidgetNumeralsWeekList(numeralsWeek));
  }
  void upNumeral() {
    emit(getAllWidgetNumeralsWeekList(state[NUMERALS_WEEK.NUMERALS]![LIST_HALF_SCREEN_ACTIVE_INDEX].getNumeralsWeek().addNumerals(1)));
  }
  void downNumerals() {
    emit(getAllWidgetNumeralsWeekList(state[NUMERALS_WEEK.NUMERALS]![LIST_HALF_SCREEN_ACTIVE_INDEX].getNumeralsWeek().downNumerals(1)));
  }
  void upWeek() {
    emit(getAllWidgetNumeralsWeekList(state[NUMERALS_WEEK.WEEK]![LIST_HALF_SCREEN_ACTIVE_INDEX].getNumeralsWeek().addWeek(1)));
  }
  void downWeek() {
    emit(getAllWidgetNumeralsWeekList(state[NUMERALS_WEEK.WEEK]![LIST_HALF_SCREEN_ACTIVE_INDEX].getNumeralsWeek().downWeek(1)));
  }
}

Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>> getAllWidgetNumeralsWeekList(NumeralsWeek numeralsWeek) {
  Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>> rezult = {};
  NUMERALS_WEEK type = NUMERALS_WEEK.NUMERALS;
  Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>> rez = getWidgetNumeralsWeekList(numeralsWeek, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  type = NUMERALS_WEEK.WEEK;
  rez = getWidgetNumeralsWeekList(numeralsWeek, type);
  rezult.putIfAbsent(type, () => rez[type]!);
  return rezult;
}

Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>> getWidgetNumeralsWeekList(NumeralsWeek numeralsWeekSrc, NUMERALS_WEEK type) {
  Map<NUMERALS_WEEK, List<NumeralsWeekNameColor>> rezult = {};
  List<NumeralsWeekNameColor> rez = List.filled(LIST_HALF_SCREEN_INDEX_LEN, NumeralsWeekNameColor(numeralsWeekSrc, "", SCREEN_INACTIVE_COLOR));
  Color currentColor;
  NumeralsWeek numeralsWeekCurrent;
  for (var i = LIST_HALF_SCREEN_INDEX_LEN - 1; i >= 0; i--) {
    if (i == LIST_HALF_SCREEN_ACTIVE_INDEX) {
      currentColor = SCREEN_ACTIVE_COLOR;
    } else {
      currentColor = SCREEN_INACTIVE_COLOR;
    }
    switch (type) {
      case NUMERALS_WEEK.NUMERALS:
        numeralsWeekCurrent = NumeralsWeek(week: numeralsWeekSrc.week, numerals: numeralsWeekSrc.numerals).addNumerals(i - LIST_HALF_SCREEN_ACTIVE_INDEX);
        rez[i] = NumeralsWeekNameColor(numeralsWeekCurrent, numeralsWeekCurrent.numerals.name, currentColor);
        break;
      case NUMERALS_WEEK.WEEK:
        numeralsWeekCurrent = NumeralsWeek(week: numeralsWeekSrc.week, numerals: numeralsWeekSrc.numerals).addWeek(i - LIST_HALF_SCREEN_ACTIVE_INDEX);
        rez[i] = NumeralsWeekNameColor(numeralsWeekCurrent, numeralsWeekCurrent.week.name, currentColor);
        break;
    }
  }
  rezult[type] = rez;
  return rezult;
}

class SpecFrequencyCubit extends Cubit<List<SpecFrequencyNameColor>> {
  SpecFrequencyCubit() : super(getWidgetFrequencyList(SPEC_FREQUENCY_DEFAULT));
  void reset(SpecFrequency frequency) {
    emit(getWidgetFrequencyList(frequency));
  }
  void upFrequency() {
    emit(getWidgetFrequencyList(state[LIST_HALF_SCREEN_ACTIVE_INDEX].getFrequency().add(1)));
  }
  void downFrequency() {
    emit(getWidgetFrequencyList(state[LIST_HALF_SCREEN_ACTIVE_INDEX].getFrequency().substract(1)));
  }
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

class SpecIntervalCubit extends Cubit<List<SpecIntervalNameColor>> {
  SpecIntervalCubit() : super(getWidgetIntervalList(SPEC_INTERVAL_DEFAULT));
  void reset(SpecInterval interval) {
    emit(getWidgetIntervalList(interval));
  }
  void up() {
    emit(getWidgetIntervalList(state[LIST_HALF_SCREEN_ACTIVE_INDEX].getInterval().add(1)));
  }
  void down() {
    emit(getWidgetIntervalList(state[LIST_HALF_SCREEN_ACTIVE_INDEX].getInterval().down(1)));
  }
}

List<SpecIntervalNameColor> getWidgetIntervalList(SpecInterval intervalSrc) {
  List<SpecIntervalNameColor> rez = List.filled(LIST_HALF_SCREEN_INDEX_LEN, SpecIntervalNameColor(intervalSrc, "", SCREEN_INACTIVE_COLOR));
  Color currentColor;
  SpecInterval intervalCurrent;
  for (var i = LIST_HALF_SCREEN_INDEX_LEN - 1; i >= 0; i--) {
    if (i == LIST_HALF_SCREEN_ACTIVE_INDEX) {
      currentColor = SCREEN_ACTIVE_COLOR;
    } else {
      currentColor = SCREEN_INACTIVE_COLOR;
    }
    intervalCurrent = SpecInterval(pos: intervalSrc.pos).add(i - LIST_HALF_SCREEN_ACTIVE_INDEX);
    rez[i] = SpecIntervalNameColor(intervalCurrent, intervalCurrent.pos.toString(), currentColor);
  }
  return rez;
}

// todo
// class SpecCalendarCubit extends Cubit<CalendarSpecBox> {
//   final SpecFrequencyCubit specFrequencyCubit;
//   final SpecIntervalCubit specIntervalCubit;
//   final WeekDayCubit weekDayCubit;
//   final NumeralsWeekCubit numeralsWeekCubit;
//   final MonthDayCubit monthDayCubit;
//   final YearMonthCubit yearMonthCubit;
//
//   SpecCalendarCubit({required this.specFrequencyCubit,
//     required this.specIntervalCubit,
//     required this.weekDayCubit,
//     required this.numeralsWeekCubit,
//     required this.monthDayCubit,
//     required this.yearMonthCubit}) : super(CalendarSpecBox.empty());
//
//   String getTitle() {
//     String rez = 'TaskScheduleScreen.ActivityRepeat'.tr();
//     rez += ' ' + 'TaskScheduleScreen.Every'.tr();
//     SpecInterval interval = specIntervalCubit.state[LIST_HALF_SCREEN_ACTIVE_INDEX]._interval;
//     rez += interval.pos > 1 ? ' ${interval.pos}' : "";
//     rez += ' ${specFrequencyCubit.state[LIST_HALF_SCREEN_ACTIVE_INDEX]._frequency.specFreq.name}';
//     NumeralsWeek? numeralsWeek = numeralsWeekCubit.state[NUMERALS_WEEK.NUMERALS]?[LIST_HALF_SCREEN_ACTIVE_INDEX]._numeralsWeek;
//     if (numeralsWeek != null) {
//         rez += ', ' + numeralsWeek.numerals.name;
//         rez += ' ' + numeralsWeek.week.name;
//     }
//     Set<WEEK> weekDay = weekDayCubit.state;
//     if (weekDay.isNotEmpty) {
//       weekDay.forEach((element) {
//         rez += ', ' + element.name;
//       });
//     }
//     Set<int> monthDay = monthDayCubit.state;
//     if (monthDay.isNotEmpty) {
//       monthDay.forEach((element) {
//         rez += ', ' + element.toString();
//       });
//     }
//     Set<MONTH> yearMonth = yearMonthCubit.state;
//     if (yearMonth.isNotEmpty) {
//       yearMonth.forEach((element) {
//         rez += ', ' + element.name;
//       });
//     }
//     return rez;
//   }
// }


// String _getResult() {
//   String rez = 'TaskScheduleScreen.ActivityRepeat'.tr();
//   rez += ' ' + 'TaskScheduleScreen.Every'.tr();
//   rez += _interval.pos > 1 ? ' ${_interval.pos}' : "";
//   rez += ' ${_specFrequency.specFreq.name}';
//   if (_calendarSpecBox.specItemsMonthDay.isNotEmpty) {
//     _calendarSpecBox.specItemsMonthDay.values.first.forEach((element) {
//       rez += ', ' + element.toString();
//     });
//   }
//   if (_calendarSpecBox.specItemsWeek.isNotEmpty) {
//     _calendarSpecBox.specItemsWeek.values.first.forEach((element) {
//       rez += ', ' + element.name;
//     });
//   }
//   if (_calendarSpecBox.specItemsMonthWeek.isNotEmpty) {
//     _calendarSpecBox.specItemsMonthWeek.values.first.forEach((element) {
//       rez += ', ' + element.keys.first.name + ' ' + element.values.first.name;
//     });
//   }
//   if (_calendarSpecBox.specItemsYearMonth.isNotEmpty) {
//     _calendarSpecBox.specItemsYearMonth.values.first.forEach((element) {
//       rez += ', ' + element.name;
//     });
//   }
//   return rez;
