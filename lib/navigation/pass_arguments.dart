import '../model/entity.dart';
import '../model/person.dart';

class ScreenArguments {
  final String title;
  final Map<String, String> btnTitleMap;

  ScreenArguments(this.title, this.btnTitleMap);
}

class PersonDatesIntervalArguments {
  final Person person;
  final DateTime dtBeg;
  final DateTime dtEnd;
  PersonDatesIntervalArguments(this.person, this.dtBeg, this.dtEnd);
}

class PersonHierarchEntityArguments {
  final Person person;
  final HierarchEntity entity;
  PersonHierarchEntityArguments(this.person, this.entity);
}

class PersonArguments {
  final Person person;
  PersonArguments(this.person);
}