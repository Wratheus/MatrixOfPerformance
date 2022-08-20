import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/cubit/main_management_page_cubit.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/cubit/main_management_page_cubit.dart';


class GroupTableView extends StatelessWidget {
  const GroupTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[400],
          ),
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: (state as MainManagementPageLoadedState).tableData.length+1,
                    itemBuilder: (context, row) {
                      if(row == 0) {
                        return SizedBox(
                            height: 20,
                            width: 20,
                            child: GridView.builder(
                              itemCount: (state).tableData[row].length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (state).tableData[row].length
                              ),
                              itemBuilder: (context, column) {
                                return Text((state).tableData[row].keys.elementAt(column).toString());
                                }));
                      }
                      row--;
                      return SizedBox(
                        height: 20,
                        width: 20,
                        child: GridView.builder(
                            itemCount: (state).tableData[row].length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: (state).tableData[row].length
                            ),
                            itemBuilder: (context, column) {
                              return Text((state).tableData[row].values.elementAt(column).toString());
                            }),
                      );
                    }
                ),
              ),
              /*DataTable(
            columns: getColumns(skillValues),
            rows: getRows(rawValues),
          ),*/
            ],
          ),
        );
      },
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
    rows.forEach((row) {
      print(row);
      dataRows.add(DataRow(cells: getCells(row)));
    });
    return dataRows;
  }


}
