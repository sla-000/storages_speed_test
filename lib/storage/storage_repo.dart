import 'dart:async';

abstract class StorageRepo {
  FutureOr<void> fill(List<String> keys);

  FutureOr<bool> isPresent(String key);

  FutureOr<void> dispose();
}
