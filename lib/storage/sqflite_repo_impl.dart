import 'dart:async';
import 'dart:io';

import 'package:ids_list/storage/storage_repo.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class SqfliteRepoImpl implements StorageRepo {
  SqfliteRepoImpl() {
    _open();
  }

  late final Database _db;

  final Completer<void> _initCompleter = Completer();

  static const String kKey = 'test_table';

  Future<void> _open() async {
    try {
      _db = await openDatabase(
        _dbFilePath,
        version: 1,
        onCreate: onCreateDb,
      );

      _initCompleter.complete(null);
    } on Exception catch (error, stackTrace) {
      _initCompleter.completeError(error, stackTrace);
    }
  }

  FutureOr<void> onCreateDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $kKey (id INTEGER PRIMARY KEY, key TEXT, value TEXT)');
  }

  String get _dbFilePath => path.join(Directory.systemTemp.path, '$kKey.db');

  @override
  Future<void> fill(List<String> keys) async {
    await _initCompleter.future;

    await _db.transaction((Transaction transaction) async {
      for (final key in keys) {
        await transaction.insert(kKey, {'key': key});
      }
    });
  }

  @override
  Future<bool> isPresent(String value) async {
    await _initCompleter.future;

    final List<Map<String, Object?>> query = await _db.query(
      kKey,
      columns: ['key'],
      limit: 1,
      where: 'key == ?',
      whereArgs: [value],
    );

    if (query.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Future<void> dispose() async {
    await _initCompleter.future;

    await _db.close();
    await deleteDatabase(_dbFilePath);
  }
}
