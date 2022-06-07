import 'dart:async';

import 'package:ids_list/storage/storage_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kKey = 'prefs-a9564ebc3289b7a14551baf8ad5ec60a';

class SharedPrefsRepoImpl implements StorageRepo {
  late final SharedPreferences _prefs;

  @override
  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  @override
  Future<void> fill(List<String> keys) => _prefs.setStringList(_kKey, keys);

  @override
  int dbSize() => -1;

  @override
  Future<bool> isPresent(String key) async {
    final Set<String> values =
        _prefs.getStringList(_kKey)?.toSet() ?? <String>{};

    return values.contains(key);
  }

  @override
  Future<void> dispose() => _prefs.remove(_kKey);
}
