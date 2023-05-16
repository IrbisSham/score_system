import 'package:tuple/tuple.dart';

class Schedule {
  final DateTime date;
  final String duration;

  Schedule({required DateTime date, String duration = ""}) :
        this.date = date,
        this.duration = duration;

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic> {
      "date" : date,
      "duration" : duration,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Schedule
              && runtimeType == other.runtimeType
              && date == other.date
              && duration == other.duration;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + date.hashCode;
    result = 37 * result + duration.hashCode;
    return result;
  }

  static Tuple2<int, int> parseDuration(String str) {
    return Tuple2(int.parse(str.substring(0, 3)), int.parse(str.substring(3)));
  }

  static String durationTupleToText(Tuple2<int, int> hourMin) {
    return "${hourMin.item1}:${hourMin.item2}";
  }

  static String durationToText(int hour, int min) {
    return "$hour:$min";
  }

}