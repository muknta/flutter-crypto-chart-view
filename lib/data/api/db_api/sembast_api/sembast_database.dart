import 'dart:async';

import 'package:crypto_chart_view/data/api/utils/settings/api_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDatabase {
  SembastDatabase._();

  static final _singleton = SembastDatabase._();

  static SembastDatabase get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;

  String? _appPathNullable;
  Future<String> get _appPath async => _appPathNullable ?? (await getApplicationDocumentsDirectory()).path;

  static int get negativeResultValue => -1;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future<void> _openDatabase() async {
    final dbPath = '${await _appPath}/$sembastDBName';
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return _dbOpenCompleter!.complete(database);
  }
}
