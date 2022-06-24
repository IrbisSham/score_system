import 'package:score_system/model/person.dart';
import 'package:score_system/vocabulary/abstract_list_voc.dart';
import 'package:score_system/vocabulary/constant.dart';

class PersonData extends EntitiesData<Person>{

  PersonData() :
        super(isDbMode: IS_DB_MODE);

  @override
  List<Person> getLocalData() {
    return [
      Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      Person(
        id: 2,
        name: 'Екатерина',
        family: 'Ермилова',
        fatherName: 'Евгеньевна',
        avaPath: AVA_PATH + "Kate.png",
      ),
      Person(
        id: 3,
        name: 'Елизавета',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Liza.png",
      ),
      Person(
        id: 4,
        name: 'Ксения',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Ksenia.png",
      ),
      Person(
        id: 5,
        name: 'Полина',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Polya.png",
      ),
      Person(
        id: 6,
        name: 'Юлия',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Julia.png",
      ),
    ];
  }

  @override
  String getTableName() {
    return "Person";
  }

  @override
  List<String> getColumnNames() {
    return ["id", "name", "parentIdList", "status", "family", "fathername", "avaPath", "desc"];
  }

  @override
  Person dbDataToEntity(Map<String, Object?> map) {
    return Person(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as int,
      desc: map['desc'] as String,
      parentIdList: map['parentIdList'] as String,
      family: map['family'] as String,
      avaPath: map['avaPath'] as String,
    );
  }

}