import 'package:intl/intl.dart';
import 'package:score_system/vocabulary/constant.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}

class DateUtil {

  String getDateNowInStr() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMMM, EEEE', LOCALE_LANG);
    return formatter.format(now);
  }
}