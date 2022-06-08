import 'package:flutter/material.dart';
import 'package:ids_list/di/di.dart';
import 'package:ids_list/logic/settings/settings.dart';
import 'package:ids_list/logic/table_data/table_data.dart';
import 'package:ids_list/storage/hive_repo_impl.dart';
import 'package:ids_list/storage/object_box_repo_impl.dart';
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioSelectStorage(
            groupValue: _storageSwitch,
            storage: StorageSwitch.sharedPreferences,
            enabled: widget.enabled,
            onSelect: () => SharedPrefsRepoImpl(),
            onUpdate: (StorageSwitch storage) =>
                setState(() => _storageSwitch = storage),
          ),
          RadioSelectStorage(
            groupValue: _storageSwitch,
            storage: StorageSwitch.sqfliteSimple,
            enabled: widget.enabled,
            onSelect: () => SqfliteSimpleRepoImpl(),
            onUpdate: (StorageSwitch storage) =>
                setState(() => _storageSwitch = storage),
          ),
          RadioSelectStorage(
            groupValue: _storageSwitch,
            storage: StorageSwitch.sqfliteIndexed,
            enabled: widget.enabled,
            onSelect: () => SqfliteIndexedRepoImpl(),
            onUpdate: (StorageSwitch storage) =>
                setState(() => _storageSwitch = storage),
          ),
          RadioSelectStorage(
            groupValue: _storageSwitch,
            storage: StorageSwitch.hive,
            enabled: widget.enabled,
            onSelect: () => HiveRepoImpl(),
            onUpdate: (StorageSwitch storage) =>
                setState(() => _storageSwitch = storage),
          ),
          RadioSelectStorage(
            groupValue: _storageSwitch,
            storage: StorageSwitch.objectBox,
            enabled: widget.enabled,
            onSelect: () => ObjectBoxRepoImpl(),
            onUpdate: (StorageSwitch storage) =>
                setState(() => _storageSwitch = storage),
          ),
        ],
      ),
    );
  }
}

class RadioSelectStorage extends StatelessWidget {
  const RadioSelectStorage({
    super.key,
    required this.groupValue,
    this.enabled = false,
    required this.storage,
    required this.onSelect,
    required this.onUpdate,
  });

  final StorageSwitch groupValue;
  final bool enabled;
  final StorageSwitch storage;
  final StorageRepo Function() onSelect;
  final void Function(StorageSwitch storage) onUpdate;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<StorageSwitch>(
      title: Text(storage.toString()),
      value: storage,
      groupValue: groupValue,
      onChanged: enabled
          ? (StorageSwitch? value) {
              di<Settings>().change(
                (SettingsState settings) => settings.copyWith(storage: storage),
              );

              di.unregister<StorageRepo>();
              di.registerFactory<StorageRepo>(() => onSelect());

              onUpdate(storage);
            }
          : null,
    );
  }
}
