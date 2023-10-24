import 'package:score_system/model/person.dart';
import 'package:score_system/util/word_util.dart';
import 'package:score_system/vocabulary/abstract_list_voc.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:sqflite/sqflite.dart';

import '../data/dbprovider.dart';
import '../locator.dart';

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
        login: 'vitaly',
        password: 'UmF2ZTFCb29t',
      ),
      Person(
        id: 2,
        name: 'Екатерина',
        family: 'Ермилова',
        fatherName: 'Евгеньевна',
        avaPath: AVA_PATH + "Kate.png",
        login: 'kate',
        password: 'cXVhbGl0eTEy',
      ),
      Person(
        id: 3,
        name: 'Елизавета',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Liza.png",
        login: 'liza',
        password: 'bGl6YTEy',
      ),
      Person(
        id: 4,
        name: 'Ксения',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Ksenia.png",
        login: 'xenya',
        password: 'eGVueWExMg==',
      ),
      Person(
        id: 5,
        name: 'Полина',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Polya.png",
        login: 'polina',
        password: 'cG9saW5hMTU=',
      ),
      Person(
        id: 6,
        name: 'Юлия',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Julia.png",
        isParticipant: false,
        login: 'julya',
        password: 'anVseWExOQ==',
      ),
    ];
  }

  @override
  String getTableName() {
    return "Person";
  }

  @override
  List<String> getColumnNames() {
    return ["id", "name", "parentIdList", "status", "family", "fathername", "avaPath",
      "desc", "login", "password"];
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
      login: map['login'] as String,
      password: map['password'] as String,
    );
  }

  Person getDbEntityByLogin(String login) {
    return getDbEntity('login = ?', [login]);
  }

  Person getLocalEntityByLogin(String login){
    return getLocalData().where((element) => element.login == login).first;
  }

  bool checkDbLoginWithPassword(String login, String password) {
    Person person = getDbEntity('login = ? and password = ?', [login, WordUtil.encode(password)]);
    return person != null;
  }

  bool checkLocalLoginWithPassword(String login, String password) {
    return getLocalData().where((element) => element.login == login
        && password == WordUtil.decode(element.password)).isNotEmpty;
  }

}