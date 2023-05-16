import 'package:loggy/loggy.dart';
import 'package:score_system/data/dbprovider.dart';
import 'package:score_system/model/entity.dart';
import 'package:sqflite/sqflite.dart';

import '../locator.dart';
import 'constant.dart';

abstract class EntitiesData<T extends BaseEntity> {

  final bool isDbMode;

  EntitiesData({required bool isDbMode}) :
    this.isDbMode = isDbMode;

  T dbDataToEntity(Map<String, Object?> map);

  List<T> getData(){
    return isDbMode ? _getDbData() : getLocalData();
  }

  T getEntity(int id){
    return isDbMode ? _getDbEntity(id) : _getLocalEntity(id);
  }

  String getTableName();

  List<String> getColumnNames();

  void _setLocalData(List<T> data);

  T _getDbEntity(int id) {
    Map<String, Object?> rez = {};
    late Database db;
    final dbOpt = locator<ScoreSystemDbProvider>().init(); //open database
    dbOpt.then((value) => db = value);
    db.query(getTableName(),
              columns: getColumnNames(),
              where: 'id = ?',
              whereArgs: [id],
              )
        .then((value) => rez = value.first)
        .catchError((exception) => logError('Cannot load entity of table ${getTableName()}', exception));
    return dbDataToEntity(rez);
  }

  List<T> _getDbData() {
    List<Map<String, Object?>> rez = [];
    late Database db;
    final dbOpt = locator<ScoreSystemDbProvider>().init(); //open database
    dbOpt.then((value) => db = value);
    db.query(getTableName(),
              columns: getColumnNames(),
              )
        .then((values) => rez = values)
        .catchError((exception) => logError('Cannot load entities of table ${getTableName()}', exception));
    return rez.map((map) => dbDataToEntity(map)).toList();
  }

  List<T> getLocalData();

  T _getLocalEntity(int id){
    return getLocalData().where((element) => element.id == id).first;
  }

  int addEntity(T t){
    int rez = (isDbMode ? _addDbEntity(t) : _addLocalData(t, getLocalData()));
    return rez;
  }

  int removeEntity(T t){
    return isDbMode ? _removeDbEntity(t) : _removeLocalEntity(t, getLocalData());
  }

  int modifyEntity(T t){
    return isDbMode ? _modifyDbData(t) : _modifyLocalData(t, getLocalData());
  }

  int _modifyLocalData(T t, List<T> data) {
    int rez = data.indexWhere((element) => element.id == t.id);
    if (rez == -1) {
      return rez;
    }
    data[rez] = t;
    return rez;
  }

  int _modifyDbData(T t) {
    int rez = STATUS_EXPIRED;
    late Database db;
    final dbOpt = locator<ScoreSystemDbProvider>().init(); //open database
    dbOpt.then((value) => db = value);
    db.update(getTableName(), t.toMapNoId(),
      where: 'id = ?',
      whereArgs: [t.id],
      conflictAlgorithm: ConflictAlgorithm.rollback, //rollback changes due conflicts
    )
        .then((value) => rez = value)
        .catchError((exception) => logError('Cannot update entity $t in list', exception));
    return rez;
  }

  int _addLocalData(T t, List<T> data){
    int rez = STATUS_EXPIRED;
    int idMax = data.reduce((curr, next) => curr.id > next.id ? curr : next).id;
    t.id = idMax + 1;
    data.add(t);
    rez = t.id;
    return rez;
  }

  int _addDbEntity(T t) { //returns number of items inserted as an integer
    int rez = STATUS_EXPIRED;
    late Database db;
    final dbOpt = locator<ScoreSystemDbProvider>().init(); //open database
    dbOpt.then((value) => db = value);
    db.insert(getTableName(), t.toMapNoId(),
      conflictAlgorithm: ConflictAlgorithm.rollback, //rollback changes due conflicts
    )
        .then((value) => rez = value)
        .catchError((exception) => logError('Cannot add entity $t into list', exception));
    return rez;
  }

  int _removeLocalEntity(T t, List<T> data) {
    bool rez = data.remove(t);
    return rez ? STATUS_ACTUAL : STATUS_EXPIRED;
  }

  int _removeDbEntity(T t) {
    int rez = STATUS_EXPIRED;
    late Database db;
    final dbOpt = locator<ScoreSystemDbProvider>().init(); //open database
    dbOpt.then((value) => db = value);
    db.delete(getTableName(), where: 'id = ?', whereArgs: [t.id])
        .then((value) => rez = value)
        .catchError((exception) => logError('Cannot remove entity $t in list', exception));
    return rez;
  }

}


