import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ids_list/di/di.dart';
import 'package:ids_list/logic/table_data/table_data.dart';
import 'package:ids_list/ui/utils/table_children.dart';

class ResultsTable extends StatelessWidget {
  const ResultsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableData, TableState>(
      bloc: di<TableData>(),
      builder: (BuildContext context, TableState state) {
        final Map<StorageSwitch, List<MeasurementDto>> data = state.data;

        final int maxRows = data.values.fold(0, _selectLongest);
        final int maxColumns = data.keys.length;

        return Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(40),
                },
                border: TableBorder.all(),
                children: tableChildren(
                  context: context,
                  rows: maxRows + 1,
                  columns: maxColumns + 1,
                  builder: (BuildContext context, int column, int row) {
                    if (column == 0 && row == 0) {
                      return const Center();
                    } else if (row == 0) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '${data.keys.toList()[column - 1]}',
                              textAlign: TextAlign.center,
                            ),
                            if (_getFirstData(data, column) != null)
                              Text(
                                _getBytesText(
                                    _getFirstData(data, column)!.size),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      );
                    } else if (column == 0) {
                      return Center(
                          child: Text(
                        row.toString(),
                        textAlign: TextAlign.center,
                      ));
                    }

                    if (column > data.keys.length ||
                        row >
                            (data[data.keys.toList()[column - 1]]?.length ??
                                0)) {
                      return const Center();
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _getMicrosecondsText(
                              _getData(data, row, column).fill),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          _getMicrosecondsText(
                              _getData(data, row, column).search),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  MeasurementDto _getData(
          Map<StorageSwitch, List<MeasurementDto>> data, int row, int column) =>
      data[data.keys.toList()[column - 1]]![row - 1];

  MeasurementDto? _getFirstData(
          Map<StorageSwitch, List<MeasurementDto>> data, int column) =>
      data[data.keys.toList()[column - 1]]![0];

  String _getMicrosecondsText(Duration duration) =>
      '${duration.inMicroseconds} µs';
  String _getBytesText(int bytes) => '$bytes B';

  int _selectLongest(int previousValue, List<MeasurementDto> element) =>
      (previousValue > element.length) ? previousValue : element.length;
}
