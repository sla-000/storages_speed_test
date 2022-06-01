import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum StorageSwitch {
  sharedPreferences,
  sqfliteSimple,
  sqfliteIndexed,
  hive,
}

@immutable
class MeasurementData extends Equatable {
  const MeasurementData({
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

class TableData {
  final Map<StorageSwitch, List<MeasurementData>> data =
      <StorageSwitch, List<MeasurementData>>{};

  void add(StorageSwitch storageSwitch, MeasurementData value) {
    if (data[storageSwitch] == null) {
      data[storageSwitch] = <MeasurementData>[];
    }

    data[storageSwitch]!.add(value);
  }
}
