import 'dart:async';
import 'dart:io';

import 'package:ids_list/storage/storage_repo.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

abstract class SqfliteRepoImpl implements StorageRepo {
  SqfliteRepoImpl() {
    _open();
  }

  late final Database _db;

  final Completer<void> _initCompleter = Completer<void>();

  String get kKey;

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

  FutureOr<void> onCreateDb(Database db, int version);

  String get _dbFilePath => path.join(Directory.systemTemp.path, '$kKey.db');

  @override
  Future<void> fill(List<String> keys) async {
    await _initCompleter.future;

    await _db.transaction((Transaction transaction) async {
      for (final String key in keys) {
        await transaction.insert(kKey, <String, String>{'key': key});
      }
    });
  }

  @override
  Future<bool> isPresent(String value) async {
    await _initCompleter.future;

    final List<Map<String, Object?>> query = await _db.query(
      kKey,
      columns: <String>['key'],
      limit: 1,
      where: 'key == ?',
      whereArgs: <String>[value],
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
