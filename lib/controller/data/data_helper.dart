import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
// import 'package:expense_manager/db/migrations/db_script.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/model.dart';

import 'migration/migration.dart';

class DataHelper extends ChangeNotifier {
  DataHelper._();

  // static final columnId = '_id';
  // static final columnName = 'name';
  // static final columnAge = 'age';
  //We use the singleton pattern to ensure that
  //we have only one class instance and provide a global point access to it
  static final DataHelper _dbAccess = DataHelper._();
  static final String _dbName = "stronks_user_mobile_device.db";
  static late Database _database;
  factory DataHelper() => _dbAccess;
  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);

    var maxMigratedDbVersion = DbMigrator.migrations.keys.reduce(max);

    _database = await openDatabase(path,
        version: maxMigratedDbVersion,
        onOpen: (db) {}, onCreate: (Database db, int _) async {
      DbMigrator.migrations.keys.toList()
        ..sort()
        ..forEach((k) async {
          String? script = DbMigrator.migrations[k];
          await db.execute('${script!}');
        });
    }, onUpgrade: (Database db, int _, int __) async {
      var currentDbVersion = await getCurrentDbVersion(db);

      var upgradeScripts = Map.fromIterable(
          DbMigrator.migrations.keys.where((k) => k > currentDbVersion),
          key: (k) => k,
          value: (k) => DbMigrator.migrations[k]);

      if (upgradeScripts.length == 0) return;

      upgradeScripts.keys.toList()
        ..sort()
        ..forEach((k) async {
          var script = upgradeScripts[k];
          await db.execute(script!);
        });

      _upgradeDbVersion(db, maxMigratedDbVersion);
    });
    notifyListeners();
    return _database;
  }

  _upgradeDbVersion(Database db, int version) async {
    await db.rawQuery('pragma user_version = $version;');
  }

  Future<int> getCurrentDbVersion(Database db) async {
    var res = await db.rawQuery('PRAGMA user_version;', null);
    var version = res[0]['user_version'].toString();
    return int.parse(version);
  }

  /// how often do we actually do this?
  Future<void> dropDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await deleteDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getDataForRepo(String table) async {
    Database db = await _dbAccess.database;
    return await db.query(table);
  }

  //   // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> exercise, String table) async {
    Database db = await _dbAccess.database;
    return await db.insert(table, exercise,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //The data present in the table is returned as a List of Map, where each
  // row is of type map
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await _dbAccess.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount(String table) async {
    Database db = await _dbAccess.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Exercise exercise, String table) async {
    Database db = await _dbAccess.database;
    return await db.update(table, exercise.toMap(),
        where: 'id = ?', whereArgs: [exercise.id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String table) async {
    Database db = await _dbAccess.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
