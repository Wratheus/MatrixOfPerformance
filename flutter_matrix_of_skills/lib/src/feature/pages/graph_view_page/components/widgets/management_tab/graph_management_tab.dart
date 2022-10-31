import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/management_tab/comparison_management.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_drop_down_menu.dart';

import '../../../../main_management_page/components/group_table_view_controller.dart';

class GraphManagementTab extends StatelessWidget {
  final TableController tableController;
  final List<dynamic> data;

  const GraphManagementTab({Key? key, required this.tableController, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 2.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    SampleStyleContainer(
                      child: Column(
                        children: [
                          Text("Selected table: ", style: whiteTextColor),
                          GroupDropDownMenu(tableController: tableController),
                        ],
                      ),
                    ),
                    SampleStyleContainer(
                        child: ComparisonManagement(data: data, tableController: tableController)
                    ),
                  ]
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
