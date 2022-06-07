import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ids_list/storage/storage_repo.dart';
import 'package:path/path.dart' as path;

const String _kKey = 'hive-a9564ebc3289b7a14551baf8ad5ec60a';

class HiveRepoImpl implements StorageRepo {
  late final Box<String> _box;

  @override
  Future<void> init() async =>
      _box = await Hive.openBox<String>(_kKey, path: Directory.systemTemp.path);

  @override
  Future<void> fill(List<String> keys) async {
    await _box.putAll(
        <String, String>{for (final String element in keys) element: ''});
    await _box.flush();
  }

  @override
  Future<int> dbSize() async =>
      File(path.join(Directory.systemTemp.path, '$_kKey.hive')).statSync().size;

  @override
  Future<bool> isPresent(String value) async {
    final String? val = _box.get(value);

    if (val == null) {
      return false;
    }

    return val.isEmpty;
  }

  @override
  Future<void> dispose() => _box.deleteFromDisk();
}
