import 'package:flutter/material.dart';
import 'package:ids_list/di/di.dart';
import 'package:ids_list/logic/settings/settings.dart';
import 'package:ids_list/logic/table_data/table_data.dart';
import 'package:ids_list/storage/hive_repo_impl.dart';
import 'package:ids_list/storage/semblast_simple_repo_impl.dart';
import 'package:ids_list/storage/shared_prefs_repo_impl.dart';
import 'package:ids_list/storage/sqflite_indexed_repo_impl.dart';
import 'package:ids_list/storage/sqflite_simple_repo_impl.dart';
import 'package:ids_list/storage/storage_repo.dart';

class SelectStorage extends StatefulWidget {
  const SelectStorage({
    super.key,
    this.enabled = true,
  });

  final bool enabled;

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
            title: Text(StorageSwitch.sharedPreferences.toString()),
            value: StorageSwitch.sharedPreferences,
            groupValue: _storageSwitch,
            onChanged: widget.enabled
                ? (StorageSwitch? value) {
                    di<Settings>().change(
                      (SettingsState settings) =>
                          settings.copyWith(storage: value!),
                    );

                    di.unregister<StorageRepo>();
                    di.registerFactory<StorageRepo>(
                        () => SharedPrefsRepoImpl());

                    setState(() {
                      _storageSwitch = value!;
                    });
                  }
                : null,
          ),
          RadioListTile<StorageSwitch>(
            title: Text(StorageSwitch.sqfliteSimple.toString()),
            value: StorageSwitch.sqfliteSimple,
            groupValue: _storageSwitch,
            onChanged: widget.enabled
                ? (StorageSwitch? value) {
                    di<Settings>().change(
                      (SettingsState settings) =>
                          settings.copyWith(storage: value!),
                    );

                    di.unregister<StorageRepo>();
                    di.registerFactory<StorageRepo>(
                        () => SqfliteSimpleRepoImpl());

                    setState(() {
                      _storageSwitch = value!;
                    });
                  }
                : null,
          ),
          RadioListTile<StorageSwitch>(
            title: Text(StorageSwitch.sqfliteIndexed.toString()),
            value: StorageSwitch.sqfliteIndexed,
            groupValue: _storageSwitch,
            onChanged: widget.enabled
                ? (StorageSwitch? value) {
                    di<Settings>().change(
                      (SettingsState settings) =>
                          settings.copyWith(storage: value!),
                    );

                    di.unregister<StorageRepo>();
                    di.registerFactory<StorageRepo>(
                        () => SqfliteIndexedRepoImpl());

                    setState(() {
                      _storageSwitch = value!;
                    });
                  }
                : null,
          ),
          RadioListTile<StorageSwitch>(
            title: Text(StorageSwitch.hive.toString()),
            value: StorageSwitch.hive,
            groupValue: _storageSwitch,
            onChanged: widget.enabled
                ? (StorageSwitch? value) {
                    di<Settings>().change(
                      (SettingsState settings) =>
                          settings.copyWith(storage: value!),
                    );

                    di.unregister<StorageRepo>();
                    di.registerFactory<StorageRepo>(() => HiveRepoImpl());

                    setState(() {
                      _storageSwitch = value!;
                    });
                  }
                : null,
          ),
          RadioListTile<StorageSwitch>(
            title: Text(StorageSwitch.semblastSimple.toString()),
            value: StorageSwitch.semblastSimple,
            groupValue: _storageSwitch,
            onChanged: widget.enabled
                ? (StorageSwitch? value) {
                    di<Settings>().change(
                      (SettingsState settings) =>
                          settings.copyWith(storage: value!),
                    );

                    di.unregister<StorageRepo>();
                    di.registerFactory<StorageRepo>(
                        () => SemblastSimpleRepoImpl());

                    setState(() {
                      _storageSwitch = value!;
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
