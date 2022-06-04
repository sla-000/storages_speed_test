import 'dart:async';
import 'dart:io';

import 'package:ids_list/storage/storage_repo.dart';
import 'package:path/path.dart' as path;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

const String _kKey = 'semblast-simple-a9564ebc3289b7a14551baf8ad5ec60a';

class SemblastSimpleRepoImpl implements StorageRepo {
  SemblastSimpleRepoImpl() {
    _open();
  }

  late final Database _db;
  late final StoreRef<String, String> _store;

  final Completer<void> _initCompleter = Completer<void>();

  Future<void> _open() async {
    try {
      final DatabaseFactory dbFactory = databaseFactoryIo;

      _db = await dbFactory.openDatabase(_dbPath);

      _store = StoreRef<String, String>.main();

      _initCompleter.complete(null);
    } on Exception catch (error, stackTrace) {
      _initCompleter.completeError(error, stackTrace);
    }
  }

  @override
  Future<void> fill(List<String> keys) async {
    await _initCompleter.future;

    await _db.transaction((Transaction txn) async {
      for (final String key in keys) {
        await _store.record(key).put(txn, '');
      }
    });
  }

  @override
  Future<int> dbSize() async {
    final File file = File(_dbPath);
    return file.statSync().size;
  }

  @override
  Future<bool> isPresent(String value) async {
    await _initCompleter.future;

    final String? record = await _store.record(value).get(_db);

    return record != null;
  }

  @override
  Future<void> dispose() async {
    await _initCompleter.future;

    await _db.close();

    final DatabaseFactory dbFactory = databaseFactoryIo;
    await dbFactory.deleteDatabase(_dbPath);
  }

  String get _dbPath => path.join(Directory.systemTemp.path, '$_kKey.db');
}
