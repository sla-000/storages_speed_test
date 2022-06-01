import 'dart:async';

import 'package:ids_list/storage/storage_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kKey = 'prefs-a9564ebc3289b7a14551baf8ad5ec60a';

class SharedPrefsRepoImpl implements StorageRepo {
  SharedPrefsRepoImpl() {
    _open();
  }

  late final SharedPreferences _prefs;

  final Completer<void> _initCompleter = Completer();

  Future<void> _open() async {
    try {
      _prefs = await SharedPreferences.getInstance();

      _initCompleter.complete(null);
    } on Exception catch (error, stackTrace) {
      _initCompleter.completeError(error, stackTrace);
    }
  }

  @override
  Future<void> fill(List<String> keys) async {
    await _initCompleter.future;

    _prefs.setStringList(_kKey, keys);
  }

  @override
  Future<bool> isPresent(String key) async {
    await _initCompleter.future;

    Set<String> values = _prefs.getStringList(_kKey)?.toSet() ?? <String>{};

    return values.contains(key);
  }

  @override
  Future<void> dispose() async {
    await _initCompleter.future;

    await _prefs.remove(_kKey);
  }
}
