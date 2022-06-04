import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ids_list/storage/storage_repo.dart';
import 'package:path/path.dart' as path;

const String _kKey = 'hive-a9564ebc3289b7a14551baf8ad5ec60a';

class HiveRepoImpl implements StorageRepo {
  HiveRepoImpl() {
    _open();
  }

  late final Box<String> _box;

  final Completer<void> _initCompleter = Completer<void>();

  Future<void> _open() async {
    try {
      _box = await Hive.openBox<String>(_kKey, path: Directory.systemTemp.path);

      _initCompleter.complete(null);
    } on Exception catch (error, stackTrace) {
      _initCompleter.completeError(error, stackTrace);
    }
  }

  @override
  Future<void> fill(List<String> keys) async {
    await _initCompleter.future;

    await _box.putAll(
        <String, String>{for (final String element in keys) element: ''});
    await _box.flush();
  }

  @override
  Future<int> dbSize() async {
    final File file = File(path.join(Directory.systemTemp.path, '$_kKey.hive'));
    return file.statSync().size;
  }

  @override
  Future<bool> isPresent(String value) async {
    await _initCompleter.future;

    final String? val = _box.get(value);

    if (val == null) {
      return false;
    }

    return val.isEmpty;
  }

  @override
  Future<void> dispose() async {
    await _initCompleter.future;

    await _box.deleteFromDisk();
  }
}
