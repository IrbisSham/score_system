import 'package:score_system/model/activity.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/model/prize.dart';
import 'package:score_system/model/schedule.dart';
import 'package:score_system/model/task.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/task_data.dart';

import '../locator.dart';
import '../model/person_prize.dart';
import '../model/person_progress.dart';
import '../model/person_success.dart';
import '../model/person_task_progress.dart';
import '../vocabulary/person_prize_data.dart';
import '../vocabulary/prize_data.dart';

class PersonTaskId {
  final Person person;
  final int taskId;
  final List<Schedule> schedule;
  final DateTime? dtPlan;

  PersonTaskId(this.person, this.taskId, this.schedule, this.dtPlan);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonTaskId
              && runtimeType == other.runtimeType
              && person == other.person
              && taskId == other.taskId
              && schedule == other.schedule
              && dtPlan == other.dtPlan;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + person.hashCode;
    result = 37 * result + taskId.hashCode;
    result = 37 * result + schedule.hashCode;
    result = 37 * result + dtPlan.hashCode;
    return result;
  }

}

class TaskIdDateActivity {
  final int taskId;
  final Activity activity;
  final DateTime dt;

  TaskIdDateActivity(this.taskId, this.activity, this.dt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskIdDateActivity
              && runtimeType == other.runtimeType
              && taskId == other.taskId
              && activity == other.activity
              && dt.isSameDate(other.dt);

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + taskId.hashCode;
    result = 37 * result + activity.hashCode;
    result = 37 * result + DateTime(dt.year, dt.month, dt.day).hashCode;
    return result;
  }

}

class PersonService {

  /// Get person progress. If person == null then get all persons progress. If dtBegin and dtEnd are empty then for all period
  Map<Person, PersonProgress> getPersonProgress(Person? currentPerson, DateTime dtBegin, DateTime dtEnd) {
    Map<Person, PersonProgress> rezMap = {};
    /**
     * Get all plan tasks
     */
    List<TaskPlan> plans = locator<TaskPlanData>().getData();
    /**
     * Get all fact tasks
     */
    List<TaskFact> facts = locator<TaskFactData>().getData();
    /**
     * Get all actual plan tasks progresses
     */
    plans
        .where((plan) => currentPerson == null ? 1==1 : plan.person == currentPerson)
        .forEach((plan) {
          facts.where((fact) => plan.person == fact.person && plan.id == fact.taskPlan.id)
              .forEach((fact) {
                PersonProgress? oldVal = rezMap[fact.person];
                if (oldVal == null) {
                  rezMap[fact.person] = PersonProgress(person: fact.person,
                      sumAll: fact.sum,
                      sumLocal: (fact.dtExecute.isAfter(dtBegin) || fact.dtExecute.isAtSameMomentAs(dtBegin)) && (fact.dtExecute.isBefore(dtEnd) || fact.dtExecute.isAtSameMomentAs(dtEnd) ) ? fact.sum : 0
                  );
                } else {
                  rezMap[fact.person] = PersonProgress(
                      person: fact.person,
                      sumAll: oldVal.sumAll + fact.sum,
                      sumLocal: (fact.dtExecute.isAfter(dtBegin) || fact.dtExecute.isAtSameMomentAs(dtBegin)) && (fact.dtExecute.isBefore(dtEnd)  || fact.dtExecute.isAtSameMomentAs(dtEnd)) ? fact.sum : 0
                  );
                }
              });
        });
    return rezMap;
  }

  /// Get person tasks complete. If person == null then get all persons progress. If dtBegin and dtEnd are empty then for all period
  Map<Person, PersonSuccess> getPersonPrizeStat(Person? currentPerson, DateTime dtBegin, DateTime dtEnd) {
    Map<Person, PersonSuccess> rezMap = {};
    Map<Person, int> taskCompleteMap = {};
    Map<Person, int> scoreMap = {};
    Map<Person, int> prizeChooseMap = {};
    Map<Person, int> prizeGetMap = {};
    /**
     * Get all fact tasks
     */
    List<TaskFact> facts = locator<TaskFactData>().getData();
    /**
     * Get all actual plan tasks progresses
     */
    facts.where((fact) => currentPerson == null ? 1==1 : fact.person == currentPerson)
        .forEach((fact) {
          int? oldTaskCompleteVal = taskCompleteMap[fact.person];
          int? oldScoreVal = scoreMap[fact.person];
          if (
            (fact.dtExecute.isAfter(dtBegin) || fact.dtExecute.isAtSameMomentAs(dtBegin))
            &&
            (fact.dtExecute.isBefore(dtEnd) || fact.dtExecute.isAtSameMomentAs(dtEnd))
          ) {
            int taskComplete = fact.cnt;
            if (oldTaskCompleteVal == null) {
              taskCompleteMap[fact.person] = taskComplete;
            } else {
              taskCompleteMap[fact.person] = oldTaskCompleteVal + taskComplete;
            }
            int score = fact.sum * fact.cnt;
            if (oldScoreVal == null) {
              scoreMap[fact.person] = score;
            } else {
              scoreMap[fact.person] = oldScoreVal + score;
            }
          }
        });
    /**
     * Get all person prize stats
     */
    List<PersonPrize> personPrizes = locator<PersonPrizeData>().getData();
    personPrizes.where((personPrize) => currentPerson == null ? 1==1 : personPrize.person == currentPerson)
      .forEach((personPrize) {
        int? oldPrizeChooseVal = prizeChooseMap[personPrize.person];
        int? oldPrizeGetVal = prizeGetMap[personPrize.person];
        int prizeChooseVal = 1;
        if (oldPrizeChooseVal == null) {
          prizeChooseMap[personPrize.person] = prizeChooseVal;
        } else {
          prizeChooseMap[personPrize.person] = oldPrizeChooseVal + prizeChooseVal;
        }
        int prizeGetVal = personPrize.isGet ? 1 : 0;
        if (oldPrizeGetVal == null) {
          prizeGetMap[personPrize.person] = prizeGetVal;
        } else {
          prizeGetMap[personPrize.person] = oldPrizeGetVal + prizeGetVal;
        }
    });
    return rezMap;
  }

  /// Get person progress. If person == null then get all persons progress
  Map<Person, List<PersonTaskProgress>> getPersonTaskProgress(Person? currentPerson, DateTime dtBegin, DateTime dtEnd) {
    Map<Person, List<PersonTaskProgress>> rezMap = {};
    /**
     * Get all plan tasks
     */
    List<TaskPlan> plans = locator<TaskPlanData>().getData();
    /**
     * Get all fact tasks
     */
    List<TaskFact> facts = locator<TaskFactData>().getData();
    /**
     * Get all actual plan tasks progresses
     */
    plans
        .where((plan) => (currentPerson == null ? 1==1 : plan.person == currentPerson)
              )
        .forEach((plan) {
            plan.schedule.sort((plan1, plan2) {
              return plan1.date.compareTo(plan2.date);
            });
            plan.schedule.where((sched) => (sched.date.isAfter(dtBegin) || sched.date.isAtSameMomentAs(dtBegin)) && (sched.date.isBefore(dtEnd) || sched.date.isAtSameMomentAs(dtEnd))).forEach((sched) {
              List<TaskFact> factsSucc = facts.where((fact) => plan.person == fact.person && plan.id == fact.taskPlan.id
                  && (fact.dtExecute.isAfter(dtBegin) || fact.dtExecute.isAtSameMomentAs(dtBegin)) && (fact.dtExecute.isBefore(dtEnd) || fact.dtExecute.isAtSameMomentAs(dtEnd)) )
                  .toList();
              factsSucc.sort((fact1, fact2) {
                return fact1.dtExecute.compareTo(fact2.dtExecute);
              });
              Person personCurr = factsSucc.isNotEmpty ? factsSucc.first.person : plan.person;
              for( var i = 1 ; i <= sched.count; i++ ) {
                List<PersonTaskProgress>? oldVal = rezMap[personCurr];
                PersonTaskProgress personTaskProgress = PersonTaskProgress(
                  id: '${currentPerson?.id}_${plan.id}_${sched.date}_$i',
                  person: personCurr,
                  taskPlan: plan,
                  activity: plan.activity,
                  dt: factsSucc.isNotEmpty ? (i <= factsSucc.length ? factsSucc[i - 1].dtExecute : sched.date) : sched.date,
                  sum: factsSucc.isNotEmpty ? (i <= factsSucc.length ? factsSucc[i - 1].sum : plan.activity.sum) : plan.activity.sum,
                  status: factsSucc.isNotEmpty ? (i <= factsSucc.length ? TaskStatus.DONE : TaskStatus.NONE) : TaskStatus.NONE,
                );
                if (oldVal == null || oldVal.isEmpty) {
                  rezMap[personCurr] = [personTaskProgress];
                } else {
                  oldVal.add(personTaskProgress);
                  rezMap[personCurr] = oldVal;
                }
              }
          });
        });
    return rezMap;
  }

}