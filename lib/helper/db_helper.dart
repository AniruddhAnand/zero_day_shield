import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'pycos.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_pycos(id TEXT PRIMARY KEY, title TEXT, key TEXT, name TEXT)');
    }, version: 1);
  }
 
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<int> delete(String id) async {
    final db = await database();     // replacd with database instance

    return await db.delete(
      "user_pycos",     // replace with table name
      where: "id = ?",
      whereArgs: [id],   // you need the id
    );
  }
}
