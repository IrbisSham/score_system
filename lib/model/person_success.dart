import 'package:score_system/model/person.dart';
import 'package:score_system/model/schedule.dart';

class PersonSuccess {

  final Person person;
  final int taskComplete;
  final int score;
  final int prizeChoose;
  final int prizeGet;

  PersonSuccess({required Person person, required int taskComplete, required score, required prizeChoose, required prizeGet}) :
        this.person = person,
        this.taskComplete = taskComplete,
        this.score = score,
        this.prizeChoose = prizeChoose,
        this.prizeGet = prizeGet;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonSuccess
              && runtimeType == other.runtimeType
              && person == other.person
              && taskComplete == other.taskComplete
              && score == other.score
              && prizeChoose == other.prizeChoose
              && prizeGet == other.prizeGet;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + person.hashCode;
    result = 37 * result + taskComplete.hashCode;
    result = 37 * result + score.hashCode;
    result = 37 * result + prizeChoose.hashCode;
    result = 37 * result + prizeGet.hashCode;
    return result;
  }

}