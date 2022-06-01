import 'dart:async';

import 'package:ids_list/storage/sqflite_repo_impl.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteIndexedRepoImpl extends SqfliteRepoImpl {
  SqfliteIndexedRepoImpl() : super();

  @override
  FutureOr<void> onCreateDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${SqfliteRepoImpl.kKey} (id INTEGER PRIMARY KEY, key TEXT, value TEXT)');

    await db.execute(
        'CREATE INDEX ${SqfliteRepoImpl.kKey}_index ON ${SqfliteRepoImpl.kKey} (key)');
  }
}
