import 'package:score_system/vocabulary/constant.dart';
import 'package:score_system/vocabulary/person_data.dart';
import 'entity.dart';

class Person extends HierarchEntity{

  late String family;
  late String fatherName;
  late String nickName;
  late String? avaPath;
  late String email;
  late bool isParticipant;

  Person({required int id, required String name, String? desc, String? parentIdList,
    int status = 0, String? family, String? fatherName, String? nickName,
    String? avaPath, String? email, bool? isParticipant}) :
        this.family = family ?? " ",
        this.fatherName = fatherName ?? " ",
        this.avaPath = avaPath,
        this.email = email ?? "",
        this.nickName = nickName ?? name,
        this.isParticipant = isParticipant ?? true,
        super(id: id, name: name, desc: desc, parentIdList: parentIdList, status: status);

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic> {
      "id" : id,
      "name" : name,
      "parentIdList" : parentIdList,
      "status" : status,
      "family" : family,
      "fatherName" : fatherName,
      "nickName" : nickName,
      "avaPath" : avaPath,
      "email" : email,
      "desc" : desc,
    };
  }

  Person.fromMap(dynamic obj) : super.fromMap(obj) {
    this.family = obj['family'];
    this.fatherName = obj['fatherName'];
    this.nickName = obj['nickName'];
    this.avaPath = obj['avaPath'];
    this.email = obj['email'];
  }

  String fio() {
    return family + " " + name! + " " + fatherName;
  }

  static Person personByFio(String fio) {
    List<String> ar = fio.split(" ");
    return PersonData().getData().where((person) => ar[0] == person.family && ar[1] == person.name && (ar.length > 2 ? ar[2] == person.fatherName : true)).toList().first;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Person
              && runtimeType == other.runtimeType
              && id == other.id
              && name == other.name
              && desc == other.desc
              && family == other.family
              && fatherName == other.fatherName
              && nickName == other.nickName
              && avaPath == other.avaPath
              && email == other.email;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + desc.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + family.hashCode;
    result = 37 * result + fatherName.hashCode;
    result = 37 * result + nickName.hashCode;
    result = 37 * result + avaPath.hashCode;
    result = 37 * result + email.hashCode;
    return result;
  }

}

Person PERSON_DUMMY = Person(id: 0, name: DUMMY);
