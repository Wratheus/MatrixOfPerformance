import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_drop_down_menu.dart';

import '../../main_management_page/components/group_table_view_controller.dart';

class GraphManagementTab extends StatelessWidget {
  final TableController tableController;
  const GraphManagementTab({Key? key, required this.tableController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SampleStyleContainer(
                  child: Column(
                    children: [
                      Text("Selected table: ", style: whiteTextColor),
                      GroupDropDownMenu(tableController: tableController)
                    ],
                  ),
                )
              ]
            ),
          ],
        ),
      ],
    );
  }
}