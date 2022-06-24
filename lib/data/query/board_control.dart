import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:score_system/model/board.dart';
import 'package:score_system/data/dbprovider.dart';

class BoardControl {

  BallSystDbProvider con = new BallSystDbProvider();

  //insertion
  Future<int> add(Board item) async { //returns number of items inserted as an integer
    final db = await con.init(); //open database
    return db.insert("Board", item.toMap(), //toMap() function from Model
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  // select all
  Future<List<Board>> getAll() async { //returns the memos as a list (array)
    final db = await con.init();
    final maps = await db.query("Board"); //query all the rows in a table as an array of maps
    return maps.isNotEmpty ? maps.map((c) => Board.fromMap(c)).toList() : [];
  }

  // delete by ID
  Future<int> delete(int id) async { //returns number of items deleted
    final db = await con.init();
    int result = await db.delete(
        "Board", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );
    return result;
  }

  // update by ID
  Future<int> update(int id, Board item) async { // returns the number of rows updated
    final db = await con.init();
    int result = await db.update(
        "Board",
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
    );
    return result;
  }

}
