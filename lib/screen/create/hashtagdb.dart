import 'dart:async';
import 'dart:io';
import 'package:geneexpert/auth/auth_state.dart';
import 'package:geneexpert/screen/create/hashtag_create_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String hashtagTable = 'hashTag_Table';
  String colId = 'id';
  String colName = 'name';
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database;
  }

  Future<Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'note.db';
    var noteDatabase = openDatabase(path,
        version: 1, onCreate: _createDb); // mo hoac tao Database
    return noteDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $hashtagTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT)');
  }

  // view data
  Future<List<Map<String, dynamic>>> getHashTagMapList() async{
    Database db = await this.database;
    var result = await db.query(hashtagTable, orderBy: '$colName ');
    return result;
  }
  // add data
  Future<int> inserHashTag(HashTag hashTag) async{
    Database db = await this.database;
    var result = await db.insert(hashtagTable, hashTag.toMap());
    return result;
  }
  // delete
  Future<int> deleteHashTag(int id) async{
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $hashtagTable WHERE $colId = $id');
    return result;
  }

    Future<List<HashTag>> getHashTagList() async {
    var hashtagMapList = await getHashTagMapList();
    int count = hashtagMapList.length;

    List<HashTag> hashtagList = List<HashTag>();
    for (int i = 0; i < count; i++) {
      hashtagList.add(HashTag.fromMapObject(hashtagMapList[i]));
    }
    return hashtagList;
  }
}
