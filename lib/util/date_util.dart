import 'package:intl/intl.dart';
import 'package:score_system/vocabulary/constant.dart';

DateTime DATE_TIME_MIN = DateTime.utc(-271821,04,20);
DateTime DATE_TIME_MAX = DateTime.utc(275760,09,13);

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}

class DateUtil {

  static final DateFormat DATE_FORMATTER = DateFormat('dd MMMM, EEEE', LOCALE_LANG);

  String getDateNowInStr() {
    final DateTime now = DateTime.now();
    return DATE_FORMATTER.format(now);
  }
}