import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geneexpert/page/hashtag/detail/detail_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static const String ID = 'ID';
  static const String NAME = 'NAME';
  static const String CATEGORY = 'CATEGORY';
  static const String TAGS = 'TAGS';
  static const String POST_TABLE = 'Posts';
  
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  String dbName = "hashtagramDB.db";

  Future initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);
    var exists = await databaseExists(path);
    if (exists == false) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_, stackTrace) {
        debugPrint('DBProviderinitDB $stackTrace');
      }

      // Copy from asset
      ByteData data = await rootBundle.load(join('assets/db', dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path);
  }


  
  // Future getCamera(int id) async {
  //   final db = await database;
  //   var res =
  //       await db.query(TABLE_COLDCAMERA, where: "map_id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? MapModel.fromJsonBD(res.first) : null;
  // }


  Future<List<DetailModel>> getContents(int id) async {
    final db = await database;
    var res = await db.query(POST_TABLE,  where: "$CATEGORY = ?", whereArgs: [id]);
    List<DetailModel> list =
        res.isNotEmpty ? res.map((c) => DetailModel.fromJson(c)).toList() : [];
    return list;
  }

  // Future deleteCamera(int id) async {
  //   final db = await database;
  //   return db.delete(TABLE_COLDCAMERA, where: "map_id = ?", whereArgs: [id]);
  // }

  // Future deleteAll() async {
  //   final db = await database;
  //   return db.rawDelete("Delete from $TABLE_COLDCAMERA");
  // }

  // Future resetAllNotiCameraStatus() async {
  //   final db = await database;
  //   var res = await db
  //       .update(TABLE_COLDCAMERA, {'isShowNoti': 0, 'lat': 0, 'lon': 0});
  //   return res;
  // }

 
}
