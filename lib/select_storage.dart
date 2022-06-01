import 'package:flutter/material.dart';
import 'package:ids_list/di.dart';
import 'package:ids_list/storage/hive_repo_impl.dart';
import 'package:ids_list/storage/shared_prefs_repo_impl.dart';
import 'package:ids_list/storage/sqflite_indexed_repo_impl.dart';
import 'package:ids_list/storage/sqflite_simple_repo_impl.dart';
import 'package:ids_list/storage/storage_repo.dart';

enum StorageSwitch {
  sharedPreferences,
  sqfliteSimple,
  sqfliteIndexed,
  hive,
}

class SelectStorage extends StatefulWidget {
  const SelectStorage({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectStorage> createState() => _SelectStorageState();
}

class _SelectStorageState extends State<SelectStorage> {
  StorageSwitch _storageSwitch = StorageSwitch.sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: <Widget>[
          RadioListTile<StorageSwitch>(
            title: const Text('Shared Preferences'),
            value: StorageSwitch.sharedPreferences,
            groupValue: _storageSwitch,
            onChanged: (StorageSwitch? value) {
              di.unregister<StorageRepo>();

              di.registerLazySingleton<StorageRepo>(
                  () => SharedPrefsRepoImpl());

              setState(() {
                _storageSwitch = value!;
              });
            },
          ),
          RadioListTile<StorageSwitch>(
            title: const Text('Sqflite Simple'),
            value: StorageSwitch.sqfliteSimple,
            groupValue: _storageSwitch,
            onChanged: (StorageSwitch? value) {
              di.unregister<StorageRepo>();

              di.registerLazySingleton<StorageRepo>(
                  () => SqfliteSimpleRepoImpl());

              setState(() {
                _storageSwitch = value!;
              });
            },
          ),
          RadioListTile<StorageSwitch>(
            title: const Text('Sqflite Indexed'),
            value: StorageSwitch.sqfliteIndexed,
            groupValue: _storageSwitch,
            onChanged: (StorageSwitch? value) {
              di.unregister<StorageRepo>();

              di.registerLazySingleton<StorageRepo>(
                  () => SqfliteIndexedRepoImpl());

              setState(() {
                _storageSwitch = value!;
              });
            },
          ),
          RadioListTile<StorageSwitch>(
            title: const Text('Hive'),
            value: StorageSwitch.hive,
            groupValue: _storageSwitch,
            onChanged: (StorageSwitch? value) {
              di.unregister<StorageRepo>();

              di.registerLazySingleton<StorageRepo>(() => HiveRepoImpl());

              setState(() {
                _storageSwitch = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
