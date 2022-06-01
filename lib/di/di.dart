import 'package:get_it/get_it.dart';
import 'package:ids_list/logic/settings/settings.dart';
import 'package:ids_list/logic/table_data/table_data.dart';
import 'package:ids_list/storage/shared_prefs_repo_impl.dart';
import 'package:ids_list/storage/storage_repo.dart';

final GetIt di = GetIt.instance;

void initDi() {
  di.registerFactory<StorageRepo>(() => SharedPrefsRepoImpl());

  di.registerLazySingleton<TableData>(
    () => TableData(),
    dispose: (TableData bloc) => bloc.close(),
  );

  di.registerLazySingleton<Settings>(
    () => Settings(),
    dispose: (Settings bloc) => bloc.close(),
  );
}

void disposeDi() {
  di.reset();
}
