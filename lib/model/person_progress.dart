import 'package:score_system/model/person.dart';

class PersonProgress {

  final Person person;
  final int sumAll;
  final int sumLocal;

  PersonProgress({required Person person, required int sumAll, required sumLocal}) :
        this.person = person,
        this.sumAll = sumAll,
        this.sumLocal = sumLocal;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonProgress
              && runtimeType == other.runtimeType
              && person == other.person
              && sumLocal == other.sumLocal
              && sumAll == other.sumAll;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + person.hashCode;
    result = 37 * result + sumAll.hashCode;
    result = 37 * result + sumLocal.hashCode;
    return result;
  }

}