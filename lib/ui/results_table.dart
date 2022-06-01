import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ids_list/di/di.dart';
import 'package:ids_list/logic/table_data/table_data.dart';

class ResultsTable extends StatelessWidget {
  const ResultsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableData, TableState>(
      bloc: di<TableData>(),
      builder: (BuildContext context, TableState state) {
        print('data=${state.data}');

        final Map<StorageSwitch, List<MeasurementDto>> data = state.data;

        final int maxLength = data.values.fold(0, _selectBiggest);

        final List<TableRow> rows = data.keys
            .map<TableRow>(
              (StorageSwitch storage) => _getRow(data, storage),
            )
            .toList()
          ..insert(
            0,
            TableRow(
              children: List<Widget>.generate(
                maxLength + 1,
                (int index) =>
                    index == 0 ? const Center() : Text('${index - 1}'),
              ),
            ),
          );

        return Table(
          border: TableBorder.all(),
          children: rows,
        );
      },
    );
  }

  TableRow _getRow(
      Map<StorageSwitch, List<MeasurementDto>> state, StorageSwitch storage) {
    return TableRow(
      children: state[storage]!
          .map<Widget>(
            (MeasurementDto data) =>
                Text('${_getText(data.fill)}\n${_getText(data.search)}'),
          )
          .toList()
        ..insert(0, Text(storage.toString())),
    );
  }

  String _getText(Duration duration) => duration.inMicroseconds.toString();

  int _selectBiggest(int previousValue, List<MeasurementDto> element) =>
      (previousValue > element.length) ? previousValue : element.length;
}
