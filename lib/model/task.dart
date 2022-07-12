import 'package:score_system/model/activity.dart';
import 'package:score_system/model/entity.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/model/schedule.dart';
import 'package:tuple/tuple.dart';

/// Status: 0 - valid, -1 - invalid
class TaskPlan extends HierarchEntity {
  late Activity activity;
  late List<Schedule> schedule;
  late Person person;

  TaskPlan({required int id, required Activity activity, String? name, String? desc, int status = 0,
    required List<Schedule> schedule, required Person person}) :
        this.activity = activity,
        this.schedule = schedule,
        this.person = person,
        super(id: id, name: name, desc: desc, status: status);

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic> {
      "id" : id,
      "activity" : activity,
      "status" : status,
      "desc" : desc,
      "schedule" : schedule,
      "person" : person,
    };
  }

  TaskPlan.fromMap(dynamic obj) : super.fromMap(obj) {
    this.activity = obj['activity'];
    this.schedule = obj['schedule'];
    this.person = obj['person'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskPlan
              && runtimeType == other.runtimeType
              && id == other.id
              && activity == other.activity
              && desc == other.desc
              && status == other.status
              && schedule == other.schedule
              && person == other.person;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + activity.hashCode;
    result = 37 * result + id.hashCode;
    result = 37 * result + desc.hashCode;
    result = 37 * result + status.hashCode;
    result = 37 * result + schedule.hashCode;
    result = 37 * result + person.hashCode;
    return result;
  }

}

/// 0 - empty, 1 - done, -1 - invalid, 3 - fail, 5 - ill, 7 - friend, 9 - other
enum TaskStatus {
  NONE,
  DONE,
  INVALID,
  FAIL,
  ILL,
  FRIEND,
  OTHER,
}

extension TaskStatusExtension on TaskStatus {

  static const statuses = {
    TaskStatus.NONE: Tuple2(0, 'Пусто'),
    TaskStatus.DONE: Tuple2(1, 'Сделано'),
    TaskStatus.INVALID: Tuple2(-1, 'Ошибочное'),
    TaskStatus.FAIL: Tuple2(3, 'Провал'),
    TaskStatus.ILL: Tuple2(5, 'Болезнь'),
    TaskStatus.FRIEND: Tuple2(7, 'Друг'),
    TaskStatus.OTHER: Tuple2(9, 'Иное'),
  };

  int get status => statuses[this]!.item1;

  String get name => statuses[this]!.item2;

}

/// Status: 0 - empty, 1 - done, -1 - invalid, 3 - fail, 5 - ill, 7 - other
class TaskFact extends HierarchEntity {
  late TaskPlan taskPlan;
  late Person person;
  late DateTime dtPlan;
  late DateTime dtExecute;
  late int cnt;
  late int sum;

  TaskFact({required int id, String? name, String? desc, String? parentIdList, int status = 0,
    required TaskPlan taskPlan, required Person person, required DateTime dtPlan, required DateTime dtExecute, required int cnt, required int sum}) :
        this.taskPlan = taskPlan,
        this.person = person,
        this.dtPlan = dtPlan,
        this.dtExecute = dtExecute,
        this.cnt = cnt,
        this.sum = sum,
        super(id: id, name: name, desc: desc, parentIdList: parentIdList, status: status);

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic> {
      "id" : id,
      "status" : status,
      "desc" : desc,
      "taskPlan" : taskPlan,
      "person" : person,
      "dtPlan" : dtPlan,
      "dtExecute" : dtExecute,
      "cnt" : cnt,
      "sum" : sum,
    };
  }

  TaskFact.fromMap(dynamic obj) : super.fromMap(obj) {
    this.taskPlan = obj['taskPlan'];
    this.person = obj['person'];
    this.dtPlan = obj['dtPlan'];
    this.dtExecute = obj['dtExecute'];
    this.cnt = obj['cnt'];
    this.sum = obj['sum'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskFact
              && runtimeType == other.runtimeType
              && id == other.id
              && desc == other.desc
              && status == other.status
              && taskPlan == other.taskPlan
              && person == other.person
              && dtPlan == other.dtPlan
              && dtExecute == other.dtExecute
              && cnt == other.cnt
              && sum == other.sum;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + desc.hashCode;
    result = 37 * result + status.hashCode;
    result = 37 * result + taskPlan.hashCode;
    result = 37 * result + person.hashCode;
    result = 37 * result + dtPlan.hashCode;
    result = 37 * result + dtExecute.hashCode;
    result = 37 * result + cnt.hashCode;
    result = 37 * result + sum.hashCode;
    return result;
  }

}

