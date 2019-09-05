import 'dart:io';

import 'package:anzus/Model/ModelMyBooks.dart';
import 'package:anzus/Model/ModelTopics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String DB_FILE_NAME = 'DBAnzus.db'; // nombre que se le asignara a la base de datos

class DataBaseHelperSQL {
  static final DataBaseHelperSQL _instance = new DataBaseHelperSQL._internal();
  factory DataBaseHelperSQL() => _instance;
  DataBaseHelperSQL._internal();

  Database _database;

  Future<Database> get database async {
    /* String databasesPath = await getDatabasesPath(); // direccion de donde se guarda las bases de datos
      String path = '$databasesPath/$DB_FILE_NAME';
      await deleteDatabase(path);*/
    if (_database != null){
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
    await bd.execute("CREATE TABLE ${Topics.NAME_TABLE}(id integer, Name_Topic varchar(50), FOREIGN KEY (id) REFERENCES  ${MyBooks.NAME_TABLE} (id), PRIMARY KEY(id, Name_Topic) )");
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
  newTopics(Topics newTopic) async {
    final db = await database;
    var res = await db.insert("${Topics.NAME_TABLE}", newTopic.toMap());
    return res;
  }

  Future<Topics> getTopics(int id) async {
    final db = await database;
    List<Map> res = await db.query("${Topics.NAME_TABLE}", where: "id = ?", whereArgs: [id]);
    if (res.length > 0) {
      return Topics.fromMap(res.first);
    }else
      {
        return null;
      }
  }

  Future<List<Topics>>getAllTopics() async {
    final db = await database;
    List<Map> res = await db.query("${Topics.NAME_TABLE}");
    print("result sql: ${res.length} $db");
    return res.isNotEmpty ? res.map((c) => Topics.fromMap(c)).toList() : [];
  }


  Future<int>deleteTopic(int id) async {
    final db = await database;
    return await db.delete("${Topics.NAME_TABLE}", where: "id = ?", whereArgs: [id]);
  }

/////////////////////////////////////////////Dao Mybooks
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

  Future<int>deleteBook(MyBooks deletebook) async {
    final db = await database;
    return await db.delete("${MyBooks.NAME_TABLE}", where: "id = ?", whereArgs: [deletebook.id]);
  }

  updateBook(MyBooks newBook) async {
    final db = await database;
    var res = await db.update("${MyBooks.NAME_TABLE}", newBook.toMap(),
        where: "id = ?", whereArgs: [newBook.id]);
    return res;
  }
}

