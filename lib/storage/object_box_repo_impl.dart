import 'dart:async';
import 'dart:io';

import 'package:ids_list/objectbox.g.dart';
import 'package:ids_list/storage/storage_repo.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as path;

@Entity()
class Record {
  Record({this.id = 0, required this.key});

  int id;

  String key;
}

class ObjectBoxRepoImpl implements StorageRepo {
  ObjectBoxRepoImpl() {
    _open();
  }

  late final Store _store;
  late final Box<Record> _box;

  final Completer<void> _initCompleter = Completer<void>();

  Future<void> _open() async {
    try {
      _store = await openStore();
      _box = _store.box<Record>();

      _initCompleter.complete(null);
    } on Exception catch (error, stackTrace) {
      _initCompleter.completeError(error, stackTrace);
    }
  }

  @override
  Future<void> fill(List<String> keys) async {
    await _initCompleter.future;

    _box.putMany(keys.map((String key) => Record(key: key)).toList());
  }

  @override
  Future<int> dbSize() async {
    final File file = File(path.join(_store.directoryPath, 'data.mdb'));
    return file.statSync().size;
  }

  @override
  Future<bool> isPresent(String value) async {
    await _initCompleter.future;

    final Query<Record> query = _box.query(Record_.key.equals(value)).build();
    final Record? person = query.findFirst();

    return person != null;
  }

  @override
  Future<void> dispose() async {
    await _initCompleter.future;

    _box.removeAll();
    _store.close();
  }
}
