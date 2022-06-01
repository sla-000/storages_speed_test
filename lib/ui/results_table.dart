import 'dart:developer';

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
    return BlocBuilder<TableData, Map<StorageSwitch, List<MeasurementDto>>>(
      bloc: di<TableData>(),
      builder: (BuildContext context,
          Map<StorageSwitch, List<MeasurementDto>> state) {
        log('state=$state');

        final int maxLength = state.values.fold(0, _selectBiggest);

        final List<TableRow> rows = state.keys
            .map<TableRow>(
              (StorageSwitch storage) => _getRow(state, storage),
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
            (MeasurementDto data) => Text('${data.fill}\n${data.search}'),
          )
          .toList()
        ..insert(0, Text(storage.toString())),
    );
  }

  int _selectBiggest(int previousValue, List<MeasurementDto> element) =>
      previousValue > element.length ? previousValue : element.length;
}
