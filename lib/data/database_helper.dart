import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static late Database _db;
  Future<Database> get db async {
    return _db;
  }
  DatabaseHelper.internal();
  initDb() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_flutter.db");
    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('data', 'flutter.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
    var ourDb = await openDatabase(path);
    return ourDb;
  }
}
