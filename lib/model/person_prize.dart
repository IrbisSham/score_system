import 'package:score_system/model/person.dart';
import 'package:score_system/model/prize.dart';

import '../vocabulary/constant.dart';
import 'entity.dart';

class PersonPrize extends BaseEntity {
  Person person;
  Prize prize;
  bool isGet;
  PersonPrize({required int id, required String name, String? desc, int status = 0, required Person person, required Prize prize, bool isGet = false}) :
    this.person = person,
    this.prize = prize,
    this.isGet = isGet,
    super(id: id, name: name, desc: desc);

  Map<String,dynamic> toMap() { // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "name" : name,
      "desc" : desc,
      "person" : person,
      "prize" : prize,
      "isGet" : isGet,
    };
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is PersonPrize
    && runtimeType == other.runtimeType
    && id == other.id
    && name == other.name
    && desc == other.desc
    && person == other.person
    && prize == other.prize
    && isGet == other.isGet;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + desc.hashCode;
    result = 37 * result + person.hashCode;
    result = 37 * result + prize.hashCode;
    result = 37 * result + isGet.hashCode;
    return result;
  }
}

PersonPrize PERSON_PRIZE_DUMMY = PersonPrize(id: 0, name: DUMMY, person: PERSON_DUMMY, prize: PRIZE_DUMMY);