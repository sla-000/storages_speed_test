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
  Store? _store;
  Box<Record>? _box;

  @override
  Future<void> init() async {
    _store = await openStore();
    _box = _store!.box<Record>();
  }

  @override
  void fill(List<String> keys) =>
      _box!.putMany(keys.map((String key) => Record(key: key)).toList());

  @override
  int dbSize() =>
      File(path.join(_store!.directoryPath, 'data.mdb')).statSync().size;

  @override
  Future<bool> isPresent(String value) async {
    final Query<Record> query = _box!.query(Record_.key.equals(value)).build();
    final Record? person = query.findFirst();

    return person != null;
  }

  @override
  Future<void> dispose() async {
    _box?.removeAll();
    _store?.close();
  }
}
