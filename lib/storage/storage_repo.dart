import 'dart:async';

abstract class StorageRepo {
  FutureOr<void> init();

  FutureOr<void> fill(List<String> keys);

  FutureOr<int> dbSize();

  FutureOr<bool> isPresent(String key);

  FutureOr<void> dispose();
}
