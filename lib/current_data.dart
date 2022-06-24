import 'package:intl/intl.dart';

import 'model/person.dart';

class CurrentUser {
  static Person? person;
}

class LocalStandart {

  final String _locale;

  late DateFormat DATE_FORMAT;
  late DateFormat TIME_FORMAT;

  LocalStandart(this._locale);

  init() {
    DATE_FORMAT = DateFormat.yMMMMd(_locale);
    TIME_FORMAT = DateFormat.Hms(_locale);
  }


}