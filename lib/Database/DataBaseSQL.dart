import 'dart:io';

import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String DB_FILE_NAME = 'DBAnzus.db'; // nombre que se le asignara a la base de datos

class DataBaseHelperSQL {
  static final DataBaseHelperSQL _instance = new DataBaseHelperSQL._internal();
  factory DataBaseHelperSQL() => _instance;
  DataBaseHelperSQL._internal();

  Database _database;

  Future<Database> get database async {
    if (_database != null){
     /* String databasesPath = await getDatabasesPath(); // direccion de donde se guarda las bases de datos
      String path = '$databasesPath/$DB_FILE_NAME';
      await deleteDatabase(path);*/
      print("ya existe");
     return _database;
    }
    print("no existe");
    _database = await initDB();

    return _database;
  }


  initDB() async {
    String databasesPath = await getDatabasesPath(); // direccion de donde se guarda las bases de datos
    String path = '$databasesPath/$DB_FILE_NAME';
    print("creado");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: _onCreate);
  }

  void _onCreate(Database bd, int newVersion) async{
    await bd.execute("CREATE TABLE ${MyBooks.NAME_TABLE}(id integer primary key autoincrement, Name_Book varchar(50))");
  }
/*
  newBook(MyBooks newbook) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT Into ${MyBooks.NAME_TABLE} (id,Name_Book)"
            " VALUES (${newbook.Name_Book})");
    return res;
  }
*/
  newBook(MyBooks newbook) async {
    final db = await database;
    var res = await db.insert("${MyBooks.NAME_TABLE}", newbook.toMap());
    return res;
  }

  Future<List<MyBooks>>getAllMyBooks() async {
    final db = await database;
    List<Map> res = await db.query("${MyBooks.NAME_TABLE}");
    print("result sql: ${res.length} $db");
    return res.isNotEmpty ? res.map((c) => MyBooks.fromMap(c)).toList() : [];
  }
}

