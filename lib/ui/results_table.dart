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

        final int maxRows = data.values.fold(0, _selectBiggest);
        final int maxColumns = data.keys.length;

        return Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(120),
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
                        child: Text('${data.keys.toList()[column - 1]}'));
                  } else if (column == 0) {
                    return Center(child: Text(row.toString()));
                  }

                  if (column > data.keys.length ||
                      row >
                          (data[data.keys.toList()[column - 1]]?.length ?? 0)) {
                    return const Center();
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(_getText(_getData(data, row, column).fill)),
                      Text(_getText(_getData(data, row, column).search)),
                    ],
                  );
                },
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

  String _getText(Duration duration) => duration.inMicroseconds.toString();

  int _selectBiggest(int previousValue, List<MeasurementDto> element) =>
      (previousValue > element.length) ? previousValue : element.length;
}
