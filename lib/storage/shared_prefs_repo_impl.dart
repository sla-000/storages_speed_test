import 'package:ids_list/storage/storage_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kKey = 'prefs-a9564ebc3289b7a14551baf8ad5ec60a';

class SharedPrefsRepoImpl implements StorageRepo {
  @override
  Future<void> fill(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(_kKey, keys);
  }

  @override
  Future<bool> isPresent(String key) async {
    final prefs = await SharedPreferences.getInstance();

    Set<String> values = prefs.getStringList(_kKey)?.toSet() ?? <String>{};

    return values.contains(key);
  }

  @override
  Future<void> dispose() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(_kKey);
  }
}
