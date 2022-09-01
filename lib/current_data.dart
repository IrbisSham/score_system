import 'package:intl/intl.dart';
import 'package:score_system/util/date_util.dart';
import 'model/person.dart';

Person CURRENT_USER = PERSON_DUMMY;
DateTime CURRENT_DATA_MIN = DATE_TIME_MIN;
DateTime CURRENT_DATA_MAX = DATE_TIME_MAX;
DateFormat CURRENT_DATE_FORMAT = DateFormat.yMMMMd('ru');
DateFormat CURRENT_TIME_FORMAT = DateFormat.Hms('ru');