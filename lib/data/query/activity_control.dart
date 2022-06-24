import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:score_system/data/dbprovider.dart';
import 'package:score_system/model/activity.dart';

class ActivityControl {

  BallSystDbProvider con = new BallSystDbProvider();

  //insertion
  Future<int> add(Activity item) async { //returns number of items inserted as an integer
    final db = await con.init(); //open database
    return db.insert("Activity", item.toMap(), //toMap() function from MemoModel
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  // select all
  Future<List<Activity>> getAll() async { //returns the memos as a list (array)

    final db = await con.init();
    final maps = await db.query("Activity"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) { //create a list of memos
      return Activity(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        parentIdList: maps[i]['parentIdList'] as String,
        status: maps[i]['status'] as int,
        desc: maps[i]['desc'] as String,
      );
    });
  }

  // delete by ID
  Future<int> delete(int id) async { //returns number of items deleted
    final db = await con.init();

    int result = await db.delete(
        "Activity", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );

    return result;
  }

  // update by ID
  Future<int> update(int id, Activity item) async { // returns the number of rows updated

    final db = await con.init();

    int result = await db.update(
        "Activity",
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
    );
    return result;
  }

}
