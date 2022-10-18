import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/graph_management_tab.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/group_col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/pie_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/pyramid_chart.dart';

import '../../../../core/constants/constants.dart';
import '../../../cubit/user_data/user_data_cubit.dart';
import '../../main_management_page/components/group_table_view_controller.dart';

class GraphViewPageLayout extends StatelessWidget {
  final TableController tableController = TableController();
  GraphViewPageLayout({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      tableController.cubitContext = context; // share cubit context to tableController to have ability to update
      tableController.selectedValue = (state as UserDataLoadedState).tableControllerSelectedValue; // share selected value if it was saved to state with controller
      return RefreshIndicator(
        child: Scaffold(
          backgroundColor: MyColors.mainCanvas,
          body: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GraphManagementTab(tableController: tableController),
                  GroupColumnChart(data: (state).tableData.sublist(1)),
                  ColumnChart(data: (state).tableData.sublist(1)),
                  PieChart(data: (state).tableData.sublist(1)),
                  PyramidChart(data: (state).tableData.sublist(1)),
                ]
            ),
          ),
        ),
        onRefresh: () =>
            context.read<UserDataCubit>()
                .reloadUserData(),
      );
    });
  }
}
