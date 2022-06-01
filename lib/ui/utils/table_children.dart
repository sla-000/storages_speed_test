import 'package:flutter/material.dart';

List<TableRow> tableChildren({
  required BuildContext context,
  required int rows,
  required int columns,
  required Widget Function(BuildContext context, int column, int row) builder,
  List<LocalKey?>? rowsKeys,
}) {
  return List<TableRow>.generate(
    rows,
    (int currentRow) => TableRow(
      key: rowsKeys?[currentRow],
      children: List<Widget>.generate(
        columns,
        (int currentColumn) => builder(context, currentColumn, currentRow),
      ),
    ),
  );
}
