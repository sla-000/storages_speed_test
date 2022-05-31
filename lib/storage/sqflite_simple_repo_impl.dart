import 'dart:async';
import 'dart:io';

import 'package:ids_list/storage/storage_repo.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

const String _kKey = 'test_simple_table';

class SqfliteSimpleRepoImpl implements StorageRepo {
  SqfliteSimpleRepoImpl() {
    _open();
  }

  late final Database _db;

  final Completer<void> _initCompleter = Completer();

  Future<void> _open() async {
    try {
      _db = await openDatabase(
        _dbFilePath,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE $_kKey (id INTEGER PRIMARY KEY, key TEXT, value TEXT)');
        },
      );

      _initCompleter.complete(null);
    } on Exception catch (error, stackTrace) {
      _initCompleter.completeError(error, stackTrace);
    }
  }

  String get _dbFilePath => path.join(Directory.systemTemp.path, '$_kKey.db');

  @override
  Future<void> fill(List<String> keys) async {
    await _initCompleter.future;

    await _db.transaction((Transaction txn) async {
      for (final key in keys) {
        await txn.insert(_kKey, {'key': key});
      }
    });
  }

  @override
  Future<bool> isPresent(String value) async {
    await _initCompleter.future;

    final List<Map<String, Object?>> query = await _db.query(
      _kKey,
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
