import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  SqfliteDatabase._();

  static final _singleton = SqfliteDatabase._();

  static SqfliteDatabase get instance => _singleton;
  String? _fullDBPath;

  Database? _database;
  Future<Database> get database async => _database ??= await _openDatabase();

  Future<Database> _openDatabase() async => await openDatabase(
        _fullDBPath ??= await _getDBPath(),
        onCreate: (db, version) async {
          /// exec schemes
        },
        version: 1,
      );

  Future<void> _deleteDatabase() async {
    await deleteDatabase(_fullDBPath ??= await _getDBPath());
  }

  Future<String> _getDBPath() async {
    // final appDocumentDir = await getApplicationDocumentsDirectory();
    _fullDBPath =
        '/data/user/0/com.example.crypto_chart_view/app_flutter/sqflite.db'; //join(appDocumentDir.path, sqfliteDBName);
    return _fullDBPath!;
  }
}
