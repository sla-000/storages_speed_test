import 'dart:async';
import 'dart:io';

import 'package:ids_list/storage/storage_repo.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

abstract class SqfliteRepoImpl implements StorageRepo {
  late final Database _db;

  String get kKey;

  @override
  Future<void> init() async => _db = await openDatabase(
        _dbFilePath,
        version: 1,
        onCreate: onCreateDb,
      );

  FutureOr<void> onCreateDb(Database db, int version);

  String get _dbFilePath => path.join(Directory.systemTemp.path, '$kKey.db');

  @override
  Future<void> fill(List<String> keys) =>
      _db.transaction((Transaction transaction) async {
        for (final String key in keys) {
          await transaction.insert(kKey, <String, String>{'key': key});
        }
      });

  @override
  int dbSize() => File(_dbFilePath).statSync().size;

  @override
  Future<bool> isPresent(String value) async {
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
    await _db.close();
    await deleteDatabase(_dbFilePath);
  }
}
