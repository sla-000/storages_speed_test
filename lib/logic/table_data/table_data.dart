import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

enum StorageSwitch {
  sharedPreferences,
  sqfliteSimple,
  sqfliteIndexed,
  hive,
}

@immutable
class MeasurementDto extends Equatable {
  const MeasurementDto({
    required this.fill,
    required this.search,
  });

  final Duration fill;
  final Duration search;

  @override
  List<Object> get props => <Object>[fill, search];

  @override
  bool get stringify => true;
}

class TableData extends Cubit<Map<StorageSwitch, List<MeasurementDto>>> {
  TableData() : super(<StorageSwitch, List<MeasurementDto>>{});

  void add(StorageSwitch storageSwitch, MeasurementDto value) {
    final Map<StorageSwitch, List<MeasurementDto>> newState =
        Map<StorageSwitch, List<MeasurementDto>>.of(state);

    if (newState[storageSwitch] == null) {
      newState[storageSwitch] = <MeasurementDto>[];
    }

    newState[storageSwitch] =
        List<MeasurementDto>.unmodifiable(newState[storageSwitch]!..add(value));

    emit(Map<StorageSwitch, List<MeasurementDto>>.unmodifiable(newState));
  }
}
