import 'package:get_it/get_it.dart';
import 'package:ids_list/storage/shared_prefs_repo_impl.dart';
import 'package:ids_list/storage/storage_repo.dart';

final GetIt di = GetIt.instance;

void initDi() {
  di.registerLazySingleton<StorageRepo>(() => SharedPrefsRepoImpl());
}

void disposeDi() {
  di.reset();
}
