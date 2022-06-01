import 'dart:async';

import 'package:ids_list/storage/sqflite_repo_impl.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteSimpleRepoImpl extends SqfliteRepoImpl {
  SqfliteSimpleRepoImpl() : super();

  @override
  String get kKey => 'test_simple_table';

  @override
  FutureOr<void> onCreateDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $kKey (id INTEGER PRIMARY KEY, key TEXT, value TEXT)');
  }
}
