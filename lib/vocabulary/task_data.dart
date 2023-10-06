import 'package:loggy/loggy.dart';
import 'package:score_system/data/dbprovider.dart';
import 'package:score_system/model/activity.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/model/schedule.dart';
import 'package:score_system/model/task.dart';
import 'package:score_system/vocabulary/abstract_list_voc.dart';
import 'package:score_system/vocabulary/activity_data.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:score_system/vocabulary/person_data.dart';
import 'package:sqflite/sqflite.dart';

import '../locator.dart';

class TaskPlanData extends EntitiesData<TaskPlan>{

  TaskPlanData() :
        super(isDbMode: IS_DB_MODE);

  List<TaskPlan> _localData = [
    TaskPlan(
      id: 1,
      activity: Activity(
        id: 14,
        name: 'Сделать зарядку',
        sum: 2,
        image: ACT_PATH + 'gym.png',
      ),
      schedule: [
          Schedule(
            date: DateTime(2022, 7, 13, 8, 30),
          ),
          Schedule(
            date: DateTime(2022, 7, 13, 14, 0),
          ),
          Schedule(
            date: DateTime(2022, 7, 13, 22, 0),
          ),
      ],
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
    ),
    TaskPlan(
      id: 2,
      activity: Activity(
        id: 15,
        name: 'Протереть мебель',
        image: ACT_PATH + 'dusting_furniture.png',
        sum: 3,
      ),
      schedule: [
        Schedule(
          date: DateTime(2022, 7, 13),
        ),
        Schedule(
          date: DateTime(2022, 7, 20),
        ),
      ],
      person: Person(
        id: 3,
        name: 'Елизавета',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Liza.png",
      ),
    ),
    TaskPlan(
      id: 3,
      activity: Activity(
        id: 16,
        name: 'Глажка',
        image: ACT_PATH + 'ironing.png',
        sum: 4,
      ),
      person: Person(
        id: 2,
        name: 'Екатерина',
        family: 'Ермилова',
        fatherName: 'Евгеньевна',
        avaPath: AVA_PATH + "Kate.png",
      ),
      schedule: [
        Schedule(
          date: DateTime(2022, 7, 13),
        ),
      ],
    ),
    TaskPlan(
      id: 4,
      activity: Activity(
        id: 17,
        name: 'Заправить кровать',
        image: ACT_PATH + 'bed_make.png',
        sum: 1,
      ),
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      schedule: [
        Schedule(
          date: DateTime(2022, 7, 13),
        ),
        Schedule(
          date: DateTime(2022, 7, 14),
        ),
      ],
    ),
    TaskPlan(
      id: 5,
      activity: Activity(
        id: 18,
        name: 'Вынести мусор',
        image: ACT_PATH + 'garbage_out.png',
        sum: 2,
      ),
      person: Person(
        id: 4,
        name: 'Ксения',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Ksenia.png",
      ),
      schedule: [
        Schedule(
          date: DateTime(2022, 7, 13),
        ),
        Schedule(
          date: DateTime(2022, 7, 14),
        ),
      ],
    ),
    TaskPlan(
      id: 6,
      activity: Activity(
        id: 19,
        name: 'Приготовить еду',
        image: ACT_PATH + 'cooking.png',
        sum: 4,
      ),
      person: Person(
        id: 5,
        name: 'Полина',
        family: 'Ермилова',
        fatherName: 'Витальевна',
        avaPath: AVA_PATH + "Polya.png",
      ),
      schedule: [
        Schedule(
          date: DateTime(2022, 7, 13),
        ),
        Schedule(
          date: DateTime(2022, 7, 14),
        ),
      ],
    ),
  ];

  @override
  List<TaskPlan> getLocalData() {
    return _localData;
  }

  List<TaskPlan> _getDbData() {
    List<Map<String, Object?>> rez = [];
    late Database db;
    final dbOpt = locator<ScoreSystemDbProvider>().init(); //open database
    dbOpt.then((value) => db = value);
    db.rawQuery('''
          SELECT ${getColumnNames().map((e) => 'A.$e').join(',')} , 
          (SELECT GROUP_CONCAT(B.dtPlan || '-' || B.cnt) FROM ${getChildTableName()} B WHERE B.task_plan_id = A.id LIMIT 1) as schedule, 
          ${locator<ActivityData>().getColumnNames().map((e) => 'C.$e as ${locator<ActivityData>().getTableName()}_$e').join(',')} , 
          ${locator<PersonData>().getColumnNames().map((e) => 'D.$e as ${locator<PersonData>().getTableName()}_$e').join(',')} , 
          FROM ${getTableName()} A 
          LEFT JOIN ${getChildTableName()} B 
          ON A.id = B.task_plan_id"
          LEFT JOIN ${locator<ActivityData>().getTableName()} C 
          ON A.activity_id = C.id"
          LEFT JOIN ${locator<PersonData>().getTableName()} D 
          ON A.person_id = D.id"
        ''')
        .then((values) => rez = values)
        .catchError((exception) => logError('Cannot load entities of tables: ${getTableName()}, ${getChildTableName()}', exception));
    return rez.map((map) => dbDataToEntity(map)).toList();
  }

  @override
  TaskPlan dbDataToEntity(Map<String, Object?> map) {
    return TaskPlan(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as int,
      desc: map['desc'] as String,
      activity: Activity(
        id: map['Activity_id'] as int,
        name: map['Activity_name'] as String,
        desc: map['Activity_desc'] as String,
        parentIdList: map['Activity_parentIdList'] as String,
        status: map['Activity_status'] as int,
        sum: map['Activity_sum'] as int,
        isCategory: (map['Activity_isCategory'] as int) == 1 ? true : false,
        isCategorized: (map['Activity_isCategorized'] as int) == 1 ? true : false,
      ),
      person: Person(
        id: map['Person_id'] as int,
        name: map['Person_name'] as String,
        desc: map['Person_desc'] as String,
        parentIdList: map['Person_parentIdList'] as String,
        status: map['Person_status'] as int,
        family: map['Person_family'] as String,
        fatherName: map['Person_fatherName'] as String,
        avaPath: map['Person_avaPath'] as String,
      ),
      schedule: (map['schedule'] as String)
          .split('\,')
          .map((e) =>
            Schedule(
              date: DateTime.fromMicrosecondsSinceEpoch(int.parse(e.split('\-')[0])),
            )
          ).toList()
    );
  }

  @override
  String getTableName() {
    return "TaskPlan";
  }

  String getChildTableName() {
    return "TaskPlanSched";
  }

  @override
  List<String> getColumnNames() {
    return ["id", "activity_id", "status", "name", "desc", "person_id", "sum"];
  }

  List<String> getChildColumnNames() {
    return ["sched_id", "task_plan_id", "dtPlan", "cnt"];
  }

}

class TaskFactData extends EntitiesData<TaskFact>{

  TaskFactData() :
        super(isDbMode: IS_DB_MODE);

  List<TaskFact> _localData = [
    TaskFact(
      id: 1,
      taskPlan: TaskPlan(
        id: 1,
        activity: Activity(
          id: 14,
          name: 'Сделать зарядку',
          sum: 2,
          image: ACT_PATH + 'gym.png',
        ),
        schedule: [
          Schedule(
            date: DateTime(2022, 7, 13, 8, 30),
          ),
          Schedule(
            date: DateTime(2022, 7, 13, 14, 0),
          ),
          Schedule(
            date: DateTime(2022, 7, 13, 22, 0),
          ),
        ],
        person: Person(
          id: 1,
          name: 'Виталий',
          family: 'Ермилов',
          fatherName: 'Юрьевич',
          avaPath: AVA_PATH + "Vitaliy.png",
        ),
      ),
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      dtPlan: DateTime(2022, 7, 13, 8, 30),
      dtExecute: DateTime(2022, 7, 13, 9, 0),
      sum: 2,
    ),
    TaskFact(
      id: 2,
      taskPlan: TaskPlan(
        id: 4,
        activity: Activity(
          id: 17,
          name: 'Заправить кровать',
          image: ACT_PATH + 'bed_make.png',
          sum: 2,
        ),
        schedule: [
          Schedule(
            date: DateTime(2022, 7, 13),
          ),
          Schedule(
            date: DateTime(2022, 7, 14),
          ),
        ],
        person: Person(
          id: 1,
          name: 'Виталий',
          family: 'Ермилов',
          fatherName: 'Юрьевич',
          avaPath: AVA_PATH + "Vitaliy.png",
        ),
      ),
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      dtPlan: DateTime(2022, 7, 13),
      dtExecute: DateTime(2022, 7, 14),
      sum: 2,
    ),
    TaskFact(
      id: 3,
      taskPlan: TaskPlan(
        id: 3,
        activity: Activity(
          id: 16,
          name: 'Глажка',
          image: ACT_PATH + 'ironing.png',
          sum: 2,
        ),
        person: Person(
          id: 2,
          name: 'Екатерина',
          family: 'Ермилова',
          fatherName: 'Евгеньевна',
          avaPath: AVA_PATH + "Kate.png",
        ),
        schedule: [
          Schedule(
            date: DateTime(2022, 7, 13),
          ),
        ],
      ),
      person: Person(
        id: 2,
        name: 'Екатерина',
        family: 'Ермилова',
        fatherName: 'Евгеньевна',
        avaPath: AVA_PATH + "Kate.png",
      ),
      dtPlan: DateTime(2022, 7, 13),
      dtExecute: DateTime(2022, 7, 13),
      sum: 2,
    ),
    TaskFact(
      id: 4,
      taskPlan: TaskPlan(
        id: 2,
        activity: Activity(
          id: 15,
          name: 'Протереть мебель',
          image: ACT_PATH + 'dusting_furniture.png',
          sum: 2,
        ),
        schedule: [
          Schedule(
            date: DateTime(2022, 7, 13),
          ),
          Schedule(
            date: DateTime(2022, 7, 13),
          ),
        ],
        person: Person(
          id: 3,
          name: 'Елизавета',
          family: 'Ермилова',
          fatherName: 'Витальевна',
          avaPath: AVA_PATH + "Liza.png",
        ),
      ),
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      dtPlan: DateTime(2022, 7, 13),
      dtExecute: DateTime(2022, 7, 13),
      sum: 2,
    ),
    TaskFact(
      id: 5,
      taskPlan: TaskPlan(
        id: 1,
        activity: Activity(
          id: 14,
          name: 'Сделать зарядку',
          sum: 2,
          image: ACT_PATH + 'gym.png',
        ),
        schedule: [
          Schedule(
            date: DateTime(2022, 7, 13, 8, 30),
          ),
          Schedule(
            date: DateTime(2022, 7, 13, 14, 0),
          ),
          Schedule(
            date: DateTime(2022, 7, 13, 22, 0),
          ),
        ],
        person: Person(
          id: 1,
          name: 'Виталий',
          family: 'Ермилов',
          fatherName: 'Юрьевич',
          avaPath: AVA_PATH + "Vitaliy.png",
        ),
      ),
      person: Person(
        id: 1,
        name: 'Виталий',
        family: 'Ермилов',
        fatherName: 'Юрьевич',
        avaPath: AVA_PATH + "Vitaliy.png",
      ),
      dtPlan: DateTime(2022, 7, 13, 14, 0),
      dtExecute: DateTime(2022, 7, 13, 15, 30),
      sum: 2,
    ),
  ];

  @override
  String getTableName() {
    return "TaskFact";
  }

  List<TaskFact> _getDbData() {
    List<Map<String, Object?>> rez = [];
    late Database db;
    final dbOpt = locator<ScoreSystemDbProvider>().init(); //open database
    dbOpt.then((value) => db = value);
    db.rawQuery('''
          SELECT ${getColumnNames().map((e) => 'A.$e').join(',')} , 
          ${locator<TaskPlanData>().getColumnNames().map((e) => 'C.$e as ${locator<TaskPlanData>().getTableName()}_$e').join(',')} , 
          ${locator<PersonData>().getColumnNames().map((e) => 'D.$e as ${locator<PersonData>().getTableName()}_$e').join(',')} , 
          FROM ${getTableName()} A 
          LEFT JOIN ${locator<TaskPlanData>().getTableName()} C 
          ON A.plan_id = C.id"
          LEFT JOIN ${locator<PersonData>().getTableName()} D 
          ON A.person_id = D.id"
        ''')
        .then((values) => rez = values)
        .catchError((exception) => logError('Cannot load entities of tables: ${getTableName()}}', exception));
    return rez.map((map) => dbDataToEntity(map)).toList();
  }

  @override
  List<String> getColumnNames() {
    return ["id", "status", "desc", "plan_id", "person_id", "dtPlan", "dtExecute"];
  }

  void _setLocalData(List<TaskFact> data){
    _localData = data;
  }

  @override
  List<TaskFact> getLocalData() {
    return _localData;
  }

  @override
  TaskFact dbDataToEntity(Map<String, Object?> map) {
    return TaskFact(
        id: map['id'] as int,
        name: map['name'] as String,
        status: map['status'] as int,
        desc: map['desc'] as String,
        dtPlan: DateTime.fromMicrosecondsSinceEpoch(map['dtPlan'] as int),
        dtExecute: DateTime.fromMicrosecondsSinceEpoch(map['dtExecute'] as int),
        person: Person(
          id: map['Person_id'] as int,
          name: map['Person_name'] as String,
          desc: map['Person_desc'] as String,
          parentIdList: map['Person_parentIdList'] as String,
          status: map['Person_status'] as int,
          family: map['Person_family'] as String,
          fatherName: map['Person_fatherName'] as String,
          avaPath: map['Person_avaPath'] as String,
        ),
        taskPlan: locator<TaskPlanData>().getEntity(map['${locator<TaskPlanData>().getTableName()}_id'] as int),
        sum: map['sum'] as int,
    );
  }

}