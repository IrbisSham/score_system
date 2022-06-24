class Schedule {
  final DateTime date;
  final int count;

  Schedule({required DateTime date, int? count = 1}) :
        this.date = date,
        this.count = count ?? 1;

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic> {
      "date" : date,
      "count" : count,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Schedule
              && runtimeType == other.runtimeType
              && date == other.date
              && count == other.count;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + date.hashCode;
    result = 37 * result + count.hashCode;
    return result;
  }

}