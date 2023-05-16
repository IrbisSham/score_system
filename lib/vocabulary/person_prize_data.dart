import 'package:score_system/model/person.dart';
import 'package:score_system/model/prize.dart';
import 'package:score_system/vocabulary/abstract_list_voc.dart';
import 'package:score_system/vocabulary/constant.dart';
import '../model/person_prize.dart';

class PersonPrizeData extends EntitiesData<PersonPrize>{

  PersonPrizeData() : super(isDbMode: IS_DB_MODE);

  List<PersonPrize> _localData = [
    PersonPrize(
      id: 1,
      name: 'Мороженка',
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      prize: Prize(id: 1, name: 'prize1', sum: 2),
      isGet: true,
    ),
    PersonPrize(
      id: 2,
      name: 'Настольная игра с папой',
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      prize: Prize(id: 2, name: 'prize2', sum: 5),
    ),
    PersonPrize(
      id: 3,
      name: 'Поход',
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      prize: Prize(id: 3, name: 'prize3', sum: 20),
    ),
  ];

  @override
  List<PersonPrize> getLocalData() {
    return _localData;
  }

  @override
  String getTableName() {
    return "PersonPrize";
  }

  @override
  List<String> getColumnNames() {
    return ["id", "name", "status", "desc", "person_id", "prize_id", "isGet"];
  }

  @override
  PersonPrize dbDataToEntity(Map<String, Object?> map) {
    return PersonPrize(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as int,
      desc: map['desc'] as String,
      person: map['person'] as Person,
      prize: map['prize'] as Prize,
      isGet: map['isGet'] as bool,
    );
  }

}