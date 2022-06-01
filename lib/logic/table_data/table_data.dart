import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_data.freezed.dart';

enum StorageSwitch {
  sharedPreferences,
  sqfliteSimple,
  sqfliteIndexed,
  hive,
}

@freezed
class MeasurementDto with _$MeasurementDto {
  const factory MeasurementDto({
    required Duration fill,
    required Duration search,
  }) = _MeasurementDto;
}

@freezed
class TableState with _$TableState {
  const factory TableState({
    @Default(<StorageSwitch, List<MeasurementDto>>{})
        Map<StorageSwitch, List<MeasurementDto>> data,
  }) = _TableState;
}

class TableData extends Cubit<TableState> {
  TableData() : super(const TableState());

  void add(StorageSwitch storage, MeasurementDto value) {
    final Map<StorageSwitch, List<MeasurementDto>> newData =
        Map<StorageSwitch, List<MeasurementDto>>.of(state.data);

    print('data.hashCode=${state.data.hashCode}');
    print('newData.hashCode=${newData.hashCode}');

    if (newData[storage] == null) {
      newData[storage] = <MeasurementDto>[];
    }

    newData[storage]!.add(value);

    print('state.hashCode=${state.hashCode}');
    print(
        'state.copyWith(data: newData).hashCode=${state.copyWith(data: newData).hashCode}');

    emit(state.copyWith(data: newData));
  }
}
