import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score_system/vocabulary/constant.dart';

import '../model/entity.dart';

DateTime DATE_TIME_MIN = DateTime.utc(-271821,04,20);
DateTime DATE_TIME_MAX = DateTime.utc(275760,09,13);

extension DateUtils on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

class DateUtil {

  static final DateFormat DATE_FORMATTER = DateFormat('EEEE, dd MMMM yyyy', LOCALE_LANG);
  static final DateFormat CALENDAR_DAY_FORMATTER = DateFormat('EEEE, dd MMMM', LOCALE_LANG);
  static final DateFormat CALENDAR_HOURS_FORMATTER = DateFormat('HH', LOCALE_LANG);
  static final DateFormat CALENDAR_MIN_FORMATTER = DateFormat('mm', LOCALE_LANG);
  static final DateFormat CALENDAR_DATE_FORMATTER = DateFormat('EEEE, dd MMMM yyyy', LOCALE_LANG);
  static final DateFormat DATE_TIME_FORMATTER = DateFormat('EEEE, dd MMMM yyyy, HH:mm', LOCALE_LANG);

  String getDateNowInStr() {
    final DateTime now = DateTime.now();
    return DATE_TIME_FORMATTER.format(now);
  }

  static int daysInMonth(DateTime date) => DateTimeRange(
      start:  DateTime(date.year, date.month,1),
      end: DateTime(date.year, date.month + 1))
      .duration
      .inDays;
}

enum SCHEDULE_REPEAT {
  ONCE,
  EVERYDAY,
  EVERYWEEK,
  EVERYWEEKDAYS,
  EVERYWEEKENDS,
  EVERYMONTH,
  EVERYYEAR,
  SPECIAL,
}

extension SCHEDULE_REPEAT_STANDART_Extension on SCHEDULE_REPEAT {

  static final entities = {
    SCHEDULE_REPEAT.ONCE: IndexName(index: 0, name: 'TaskScheduleScreen.Once'.tr()),
    SCHEDULE_REPEAT.EVERYDAY: IndexName(index: 1, name: 'TaskScheduleScreen.EveryDay'.tr()),
    SCHEDULE_REPEAT.EVERYWEEK: IndexName(index: 2, name: 'TaskScheduleScreen.EveryWeek'.tr()),
    SCHEDULE_REPEAT.EVERYWEEKDAYS: IndexName(index: 3, name: 'TaskScheduleScreen.EveryWeekDays'.tr()),
    SCHEDULE_REPEAT.EVERYWEEKENDS: IndexName(index: 4, name: 'TaskScheduleScreen.EveryWeekEnds'.tr()),
    SCHEDULE_REPEAT.EVERYMONTH: IndexName(index: 5, name: 'TaskScheduleScreen.EveryMonthThisDate'.tr()),
    SCHEDULE_REPEAT.EVERYYEAR: IndexName(index: 6, name: 'TaskScheduleScreen.EveryYearThisDate'.tr()),
    SCHEDULE_REPEAT.SPECIAL: IndexName(index: 7, name: 'TaskScheduleScreen.Special'.tr()),
  };

  int get index => entities[this]!.index;

  String get name => entities[this]!.name;
}

enum SPEC_FREQ {
  MIN,
  HOUR,
  DAY,
  WEEK,
  MONTH,
  YEAR,
}

extension SPEC_FREQ_Extension on SPEC_FREQ {

  static final entities = {
    SPEC_FREQ.MIN: IndexName(index: minIndex, name: 'TaskScheduleScreen.Min'.tr()),
    SPEC_FREQ.HOUR: IndexName(index: 1, name: 'TaskScheduleScreen.Hour'.tr()),
    SPEC_FREQ.DAY: IndexName(index: minIndexBase, name: 'TaskScheduleScreen.Day'.tr()),
    SPEC_FREQ.WEEK: IndexName(index: 3, name: 'TaskScheduleScreen.Week'.tr()),
    SPEC_FREQ.MONTH: IndexName(index: 4, name: 'TaskScheduleScreen.Month'.tr()),
    SPEC_FREQ.YEAR: IndexName(index: maxIndex, name: 'TaskScheduleScreen.Year'.tr()),
  };

  static const minIndex = 0;

  static const maxIndex = 5;

  static const minIndexBase = 2;

  static const maxIndexBase = 5;

  bool get isTime => entities[this]!.index < 2;

  int get index => entities[this]!.index;

  String get name => entities[this]!.name;
}


enum WEEK {
  MON,
  TUE,
  WED,
  THU,
  FRI,
  SAT,
  SUN,
  WEEKDAYS,
  WEEKENDS,
  ALL_WEEK,
}

extension WEEK_Extension on WEEK {

  static final entities = {
    WEEK.MON: IndexName(index: 0, name: 'TaskScheduleScreen.Monday'.tr()),
    WEEK.TUE: IndexName(index: 1, name: 'TaskScheduleScreen.Tuesday'.tr()),
    WEEK.WED: IndexName(index: 2, name: 'TaskScheduleScreen.Wednesday'.tr()),
    WEEK.THU: IndexName(index: 3, name: 'TaskScheduleScreen.Thursday'.tr()),
    WEEK.FRI: IndexName(index: 4, name: 'TaskScheduleScreen.Friday'.tr()),
    WEEK.SAT: IndexName(index: 5, name: 'TaskScheduleScreen.Saturday'.tr()),
    WEEK.SUN: IndexName(index: 6, name: 'TaskScheduleScreen.Sunday'.tr()),
    WEEK.WEEKDAYS: IndexName(index: 7, name: 'TaskScheduleScreen.Weekdays'.tr()),
    WEEK.WEEKENDS: IndexName(index: 8, name: 'TaskScheduleScreen.Weekends'.tr()),
    WEEK.ALL_WEEK: IndexName(index: 9, name: 'TaskScheduleScreen.AllWeek'.tr()),
  };

  int get minIndex => 0;

  int get maxIndex => 9;

  int get index => entities[this]!.index;

  String get name => entities[this]!.name;
}

enum MONTH {
  JAN,
  FEB,
  MAR,
  APR,
  MAY,
  JUN,
  JUL,
  AUG,
  SEP,
  OKT,
  NOV,
  DEC,
}

extension MONTH_Extension on MONTH {

  static int minIndex = 0;
  static int maxIndex = 11;

  static final entities = {
    MONTH.JAN: IndexName(index: 0, name: 'TaskScheduleScreen.January'.tr()),
    MONTH.FEB: IndexName(index: 1, name: 'TaskScheduleScreen.Febrary'.tr()),
    MONTH.MAR: IndexName(index: 2, name: 'TaskScheduleScreen.March'.tr()),
    MONTH.APR: IndexName(index: 3, name: 'TaskScheduleScreen.April'.tr()),
    MONTH.MAY: IndexName(index: 4, name: 'TaskScheduleScreen.May'.tr()),
    MONTH.JUN: IndexName(index: 5, name: 'TaskScheduleScreen.June'.tr()),
    MONTH.JUL: IndexName(index: 6, name: 'TaskScheduleScreen.July'.tr()),
    MONTH.AUG: IndexName(index: 7, name: 'TaskScheduleScreen.August'.tr()),
    MONTH.SEP: IndexName(index: 8, name: 'TaskScheduleScreen.September'.tr()),
    MONTH.OKT: IndexName(index: 9, name: 'TaskScheduleScreen.October'.tr()),
    MONTH.NOV: IndexName(index: 10, name: 'TaskScheduleScreen.November'.tr()),
    MONTH.DEC: IndexName(index: 11, name: 'TaskScheduleScreen.December'.tr()),
  };

  int get index => entities[this]!.index;

  String get name => entities[this]!.name;
}

enum NUMERALS {
  FIRST,
  SECOND,
  THIRD,
  FOURTH,
  LAST,
}

extension NUMERALS_Extension on NUMERALS {

  static final entities = {
    NUMERALS.FIRST: IndexName(index: 0, name: 'TaskScheduleScreen.First'.tr()),
    NUMERALS.SECOND: IndexName(index: 1, name: 'TaskScheduleScreen.Second'.tr()),
    NUMERALS.THIRD: IndexName(index: 2, name: 'TaskScheduleScreen.Third'.tr()),
    NUMERALS.FOURTH: IndexName(index: 3, name: 'TaskScheduleScreen.Fourth'.tr()),
    NUMERALS.LAST: IndexName(index: 4, name: 'TaskScheduleScreen.Last'.tr()),
  };

  int get minIndex => 0;

  int get maxIndex => 4;

  int get index => entities[this]!.index;

  String get name => entities[this]!.name;
}

enum REPEAT_END {
  NEVER,
  TIME,
  COUNTER,
}

extension REPEAT_END_Extension on REPEAT_END {

  static final entities = {
    REPEAT_END.NEVER: IndexName(index: 0, name: 'TaskScheduleScreen.Never'.tr()),
    REPEAT_END.TIME: IndexName(index: 1, name: 'TaskScheduleScreen.Time'.tr()),
    REPEAT_END.COUNTER: IndexName(index: 2, name: 'TaskScheduleScreen.Counter'.tr()),
  };

  int get index => entities[this]!.index;

  String get name => entities[this]!.name;
}

class DayHourMin {
  int day;
  int hour;
  int min;
  DayHourMin({required this.day, required this.hour, required this.min});

  DayHourMin addDay(int day) {
    this.day += day;
    if (this.day > 364) {
      this.day = this.day - 365;
    }
    return this;
  }

  DayHourMin addHour(int hour) {
    this.hour += hour;
    if (this.hour > 23) {
      this.hour = this.hour - 24;
    }
    return this;
  }

  DayHourMin addMin(int min) {
    this.min += min;
    if (this.min > 59) {
      this.min = this.min - 60;
    }
    return this;
  }

  DayHourMin downDay(int day) {
    this.day -= day;
    if (this.day < 0) {
      this.day = 0;
    }
    return this;
  }

  DayHourMin downHour(int hour) {
    this.hour -= hour;
    if (this.hour < 0) {
      this.hour = 0;
    }
    return this;
  }

  DayHourMin downMin(int min) {
    this.min -= min;
    if (this.min < 0) {
      this.min = 0;
    }
    return this;
  }

}

enum NUMERALS_WEEK {NUMERALS, WEEK}

class NumeralsWeek {
  NUMERALS numerals;
  WEEK week;

  NumeralsWeek({required this.numerals, required this.week});

  NumeralsWeek addNumerals(int size) {
    int index = numerals.index + size;
    if (index > numerals.maxIndex) {
      index -= NUMERALS.values.length;
    }
    numerals = NUMERALS.values[index];
    return this;
  }

  NumeralsWeek downNumerals(int size) {
    int index = numerals.index + size;
    if (index < numerals.minIndex) {
      index += NUMERALS.values.length;
    }
    numerals = NUMERALS.values[index];
    return this;
  }

  NumeralsWeek addWeek(int size) {
    int index = week.index + size;
    if (index > week.maxIndex) {
      index -= WEEK.values.length;
    }
    week = WEEK.values[index];
    return this;
  }

  NumeralsWeek downWeek(int size) {
    int index = week.index + size;
    if (index < week.minIndex) {
      index += WEEK.values.length;
    }
    week = WEEK.values[index];
    return this;
  }

}

abstract class SpecCalendarObject {
  SpecCalendarObject add(int size);
  SpecCalendarObject substract(int size);
}

class SpecFrequency extends SpecCalendarObject {
  SPEC_FREQ specFreq;
  SpecFrequency({required this.specFreq});

  @override
  SpecFrequency add(int size) {
    int index = specFreq.index + size;
    if (index > SPEC_FREQ_Extension.maxIndexBase) {
      index -= (SPEC_FREQ_Extension.maxIndexBase - 1);
    }
    return SpecFrequency(specFreq: SPEC_FREQ.values[index]);
  }

  @override
  SpecFrequency substract(int size) {
    int index = specFreq.index - size;
    if (index < SPEC_FREQ_Extension.minIndexBase) {
      index += (SPEC_FREQ_Extension.maxIndexBase - 1);
    }
    return SpecFrequency(specFreq: SPEC_FREQ.values[index]);
  }

}

class SpecFrequencyNameColor {

  SpecFrequencyNameColor(this._frequency, this._name, this._color);

  SpecFrequency _frequency;
  String _name;
  Color _color;

  String getName() {
    return _name;
  }

  SpecFrequency getFrequency() {
    return _frequency;
  }

  Color getColor() {
    return _color;
  }
}

class SpecInterval {
  List<int> RANGE = Iterable<int>.generate(100).skip(1).toList();
  int pos;

  SpecInterval({required this.pos});

  SpecInterval add(int size) {
    int index = pos + size;
    if (index > RANGE.length - 1) {
      index = index - RANGE.length;
    }
    if (index < RANGE[0]) {
      index = index + RANGE.length;
    }
    this.pos = index;
    return this;
  }

  SpecInterval down(int size) {
    int index = pos - size;
    if (index < RANGE[0]) {
      index = index + RANGE.length;
    }
    if (index > RANGE.length - 1) {
      index = index - RANGE.length;
    }
    this.pos = index;
    return this;
  }

}

DayHourMin parseDuration(String src){
  return DayHourMin(day: int.parse(src.split(" ")[0]), hour: int.parse(src.split(" ")[2]), min: int.parse(src.split(" ")[4]));
}

String formatDuration(DayHourMin src){
  return "${src.day} ${'TaskScheduleScreen.Day'.tr()} ${src.hour} ${'TaskScheduleScreen.Hour'.tr()} ${src.min} ${'TaskScheduleScreen.Min'.tr()}";
}

List<int> CALENDAR_DAY = Iterable<int>.generate(32).skip(1).toList();
List<int> CALENDAR_MONTH = Iterable<int>.generate(13).skip(1).toList();
List<int> CALENDAR_YEAR = [for (var i = 1900; i <= 2100; i++) i];
List<int> CALENDAR_HOUR = [for (var i = 0; i <= 24; i++) i];
List<int> CALENDAR_MIN = [for (var i = 0; i <= 60; i++) i];

DayHourMin DAY_HOUR_MIN_DEFAULT = DayHourMin(day: 0, hour: 0, min: 10);
NumeralsWeek NUMERALS_WEEK_DEFAULT = NumeralsWeek(numerals: NUMERALS.FIRST, week: WEEK.MON);
SpecFrequency SPEC_FREQUENCY_DEFAULT = SpecFrequency(specFreq: SPEC_FREQ.DAY);
SpecInterval SPEC_INTERVAL_DEFAULT = SpecInterval(pos: 1);