import 'package:score_system/model/person.dart';
import 'package:score_system/model/schedule.dart';
import 'package:score_system/model/task.dart';

import 'activity.dart';

class PersonTaskProgress {

  final String id;
  final Person person;
  final TaskPlan taskPlan;
  final Activity activity;
  final DateTime dt;
  final int sum;
  TaskStatus status;

  PersonTaskProgress({
      required String id,
      required Person person,
      required TaskPlan taskPlan,
      required Activity activity,
      required DateTime dt,
      required int sum,
      required TaskStatus status,
  }) :
        this.id = id,
        this.person = person,
        this.taskPlan = taskPlan,
        this.activity = activity,
        this.dt = dt,
        this.sum = sum,
        this.status = status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonTaskProgress
              && runtimeType == other.runtimeType
              && id == other.id
              && person == other.person
              && taskPlan == other.taskPlan
              && activity == other.activity
              && dt == other.dt
              && sum == other.sum
              && status == other.status;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + person.hashCode;
    result = 37 * result + taskPlan.hashCode;
    result = 37 * result + activity.hashCode;
    result = 37 * result + dt.hashCode;
    result = 37 * result + sum.hashCode;
    result = 37 * result + status.hashCode;
    return result;
  }

  static makeId(TaskFact fact) => '${fact.person.id}_${fact.taskPlan.id}_${fact.dtPlan}_${fact.cnt}';
}