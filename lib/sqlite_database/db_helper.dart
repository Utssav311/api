import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_studio/model/user_model.dart';

class DbHelper {
  Database? db;

  get database async {
    if (db != null) {
      return db;
    }
    db = await createDatabase();
    return db;
  }

  createDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, "user.db");
    if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load("assets/database/shopping.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    }
    var db = await openDatabase(dbPath);
    return db;
  }

  insert(UserModel user) async {
    Map<String, dynamic> map = {};
    map["email"] = user.email;
    map["username"] = user.username;
    map["password"] = user.password;
    final db = await database;
    await db?.insert("user_table", map);
  }

  delete(int id) async {
    final db = await database;
    await db?.delete("user_table", where: "id=?", whereArgs: [id]);
  }

  getData() async {
    List<UserModel> list = [];
    final db = await database;
    final result = await db.rawQuery("SELECT * FROM user_table");
    if (result != null && result.isNotEmpty) {
      result?.forEach((element) {
        UserModel model = UserModel.fromJson(element);
        list.add(model);
      });
    }
    return list;
  }
}
