import 'dart:async';
import 'dart:io';

import 'package:path/path.dart'; //used to join paths
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:score_system/model/board.dart'; //import model class
import 'package:score_system/vocabulary/activity_data.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:score_system/vocabulary/person_data.dart';
import 'package:score_system/vocabulary/task_data.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart'; //sqflite package

class BallSystDbProvider{

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path,"ballsyst.db"); //create path to database

    return await openDatabase( //open the database or create a database if there isn't any
        path,
        version: 1,
        onCreate: (Database db,int version) async {
          await db.execute("""
          CREATE TABLE Activiy(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          desc TEXT)"""
          );
          await db.execute("""
          CREATE TABLE Prize(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          desc TEXT,
          sum REAL)"""
          );
          await db.execute("""
          CREATE TABLE Person(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          family TEXT,
          fathername TEXT)"""
          );
          await db.execute("""
          CREATE TABLE Board(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fio TEXT,
          activity TEXT,
          prize TEXT,
          sum REAL)"""
          );
        });
  }

  Future<int> addBoard(Board item) async{ //returns number of items inserted as an integer
    final db = await init(); //open database
    return db.insert("Board", item.toMap(), //toMap() function from MemoModel
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<Board>> fetchBoards() async{ //returns the memos as a list (array)
    final db = await init();
    final all = await db.query("Board"); //query all the rows in a table as an array of maps

    return all.isNotEmpty ? all.map((c) => Board.fromMap(c)).toList() : [];
  }

  Future<int> deleteBoard(int id) async{ //returns number of items deleted
    final db = await init();

    int result = await db.delete(
        "Board", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );

    return result;
  }


  Future<int> updateBoard(int id, Board item) async{ // returns the number of rows updated

    final db = await init();

    int result = await db.update(
        "Board",
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
    );
    return result;
  }

}

class ScoreSystemDbProvider{

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path, "scoresystem.db"); //create path to database

    return await openDatabase( //open the database or create a database if there isn't any
        path,
        version: 1,
        onCreate: (Database db,int version) async {
          await db.execute(
            """
              CREATE TABLE if not exists Status(id INTEGER PRIMARY KEY, name TEXT, CONSTRAINT fk_Status_id unique (id) on conflict ROLLBACK)            
            """
          );
          await db.execute(
            """
              CREATE UNIQUE INDEX if not exists Status_id ON Status (id ASC);
            """
          );
          // 0 - done, -1 - invalid, 3 - fail, 5 - ill, 7 - other
          int id1 = await db.rawInsert(
            """INSERT INTO Status(id, name) VALUES(0, "done")"""
          );
          id1 = await db.rawInsert(
            """INSERT INTO Status(id, name) VALUES(-1, "invalid")"""
          );
          id1 = await db.rawInsert(
            """INSERT INTO Status(id, name) VALUES(3, "fail")"""
          );
          id1 = await db.rawInsert(
            """INSERT INTO Status(id, name) VALUES(5, "ill")"""
          );
          id1 = await db.rawInsert(
            """INSERT INTO Status(id, name) VALUES(7, "other")"""
          );
          await db.execute(
            """
              CREATE TABLE if not exists ${getIt<PersonData>().getTableName()}(
                ${getIt<PersonData>().getColumnNames()[0]} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${getIt<PersonData>().getColumnNames()[1]} TEXT,
                ${getIt<PersonData>().getColumnNames()[2]} TEXT,
                ${getIt<PersonData>().getColumnNames()[3]} INTEGER REFERENCES Status(id) ON DELETE RESTRICT,
                ${getIt<PersonData>().getColumnNames()[4]} TEXT,
                ${getIt<PersonData>().getColumnNames()[5]} TEXT,
                ${getIt<PersonData>().getColumnNames()[6]} TEXT,
                ${getIt<PersonData>().getColumnNames()[7]} TEXT,
                CONSTRAINT fk_Person_id unique (id) on conflict ROLLBACK)
            """
          );
          await db.execute(
              """
              CREATE UNIQUE INDEX if not exists Person_id ON ${getIt<PersonData>().getTableName()} (${getIt<PersonData>().getColumnNames()[0]} ASC);
            """
          );
          await db.execute(
              """
            CREATE TABLE ${getIt<ActivityData>().getTableName()}(
              ${getIt<ActivityData>().getColumnNames()[0]} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${getIt<ActivityData>().getColumnNames()[1]} TEXT,
              ${getIt<ActivityData>().getColumnNames()[2]} INTEGER,
              ${getIt<ActivityData>().getColumnNames()[3]} TEXT,
              ${getIt<ActivityData>().getColumnNames()[4]} TEXT,
              ${getIt<ActivityData>().getColumnNames()[5]} INTEGER,
              ${getIt<ActivityData>().getColumnNames()[6]} INTEGER,
              ${getIt<ActivityData>().getColumnNames()[7]} INTEGER,
              ${getIt<ActivityData>().getColumnNames()[8]} TEXT,
              CONSTRAINT fk_Activity_id unique (id) on conflict ROLLBACK)
            """
          );
          await db.execute(
              """
              CREATE UNIQUE INDEX if not exists Activity_id ON ${getIt<ActivityData>().getTableName()} (${getIt<ActivityData>().getColumnNames()[0]} ASC);
            """
          );
          await db.execute(
            """
            CREATE TABLE ${getIt<TaskPlanData>().getTableName()}(
              ${getIt<TaskPlanData>().getColumnNames()[0]} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${getIt<TaskPlanData>().getColumnNames()[1]} INTEGER REFERENCES Activity(id) ON DELETE RESTRICT,
              ${getIt<TaskPlanData>().getColumnNames()[2]} INTEGER REFERENCES Status(id) ON DELETE RESTRICT,
              ${getIt<TaskPlanData>().getColumnNames()[3]} TEXT,
              ${getIt<TaskPlanData>().getColumnNames()[4]} TEXT,
              ${getIt<TaskPlanData>().getColumnNames()[5]} INTEGER REFERENCES Person(id) ON DELETE RESTRICT,
              ${getIt<TaskPlanData>().getColumnNames()[6]} INTEGER,
              CONSTRAINT fk_TaskPlan_id unique (id) on conflict ROLLBACK)
            """
          );
          await db.execute(
              """
              CREATE UNIQUE INDEX if not exists TaskPlan_id ON ${getIt<TaskPlanData>().getTableName()} (${getIt<TaskPlanData>().getColumnNames()[0]} ASC);
            """
          );
          await db.execute(
            """
            CREATE TABLE TaskPlanSched(
              ${getIt<TaskPlanData>().getChildColumnNames()[0]} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${getIt<TaskPlanData>().getChildColumnNames()[1]} INTEGER REFERENCES TaskPlan(id) ON DELETE RESTRICT,
              ${getIt<TaskPlanData>().getChildColumnNames()[2]} INTEGER,
              ${getIt<TaskPlanData>().getChildColumnNames()[3]} INTEGER,
              CONSTRAINT fk_TaskPlanSched_id unique (${getIt<TaskPlanData>().getChildColumnNames()[0]}) on conflict ROLLBACK)
            """
          );
          await db.execute(
              """
              CREATE UNIQUE INDEX if not exists TaskPlanSched_id ON TaskPlanSched (sched_id ASC);
            """
          );
          await db.execute(
            """
            CREATE TABLE TaskFact(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              status INTEGER REFERENCES Status(id) ON DELETE RESTRICT,
              desc TEXT,
              plan_id INTEGER REFERENCES TaskPlan(id) ON DELETE RESTRICT,
              person_id INTEGER REFERENCES Person(id) ON DELETE RESTRICT,
              dtPlan INTEGER,
              dtExecute INTEGER,
              CONSTRAINT fk_TaskFact_id unique (id) on conflict ROLLBACK)
            """
          );
          await db.execute(
              """
              CREATE UNIQUE INDEX if not exists TaskFact_id ON Person (id ASC);
            """
          );
        });
  }

}
