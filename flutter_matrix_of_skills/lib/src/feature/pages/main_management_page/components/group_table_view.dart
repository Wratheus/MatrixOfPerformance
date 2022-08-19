import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

class GroupTableView extends StatelessWidget {
  const GroupTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[400],
      ),
      child: Row(
        children: [
          DataTable(
            columns: getColumns(skillValues),
            rows: getRows(rawValues),
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) => DataColumn(label: Text(column)))
        .toList();
  }

  List<DataCell> getCells(List<dynamic> cells) {
    return cells.map((data) => DataCell(Text("$data"))).toList();
  }

  List<DataRow> getRows(List<List<dynamic>> rows) {
    List<DataRow> dataRows = [];
    rows.forEach((row) {print(row); dataRows.add(DataRow(cells: getCells(row)));});
    return dataRows;
  }


}
