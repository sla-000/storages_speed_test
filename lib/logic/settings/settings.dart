import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ids_list/logic/table_data/table_data.dart';

part 'settings.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(StorageSwitch.sharedPreferences) StorageSwitch storage,
  }) = _SettingsState;
}

class Settings extends Cubit<SettingsState> {
  Settings() : super(const SettingsState());

  void change(SettingsState Function(SettingsState settings) builder) {
    final SettingsState newState = builder(state);

    emit(newState);
  }
}
