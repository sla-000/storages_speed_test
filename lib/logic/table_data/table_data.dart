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

  void addData(StorageSwitch storage, MeasurementDto value) {
    final Map<StorageSwitch, List<MeasurementDto>> newData =
        Map<StorageSwitch, List<MeasurementDto>>.of(state.data);

    print('data.hashCode=${state.data.hashCode}');
    print('newData.hashCode=${newData.hashCode}');

    if (newData[storage] == null) {
      newData[storage] = <MeasurementDto>[];
    }

    newData[storage] = List<MeasurementDto>.unmodifiable(
      List<MeasurementDto>.of(newData[storage]!)..add(value),
    );

    emit(state.copyWith(data: newData));
  }
}
