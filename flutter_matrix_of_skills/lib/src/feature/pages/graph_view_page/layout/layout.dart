import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/management_tab/table_drop_down_menu.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/circular_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/group_col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/skillbox_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/pyramid_chart.dart';

import '../../../../core/constants/constants.dart';
import '../../../cubit/user_data/user_data_cubit.dart';
import '../../main_management_page/components/group_table_view_controller.dart';
import '../components/widgets/charts/radar_chart.dart';

class GraphViewPageLayout extends StatelessWidget {
  final TableController tableController = TableController();
  GraphViewPageLayout({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      tableController.cubitContext = context; // share cubit context to tableController to have ability to update
      tableController.selectedValue = (state as UserDataLoadedState).tableControllerSelectedValue; // share selected value if it was saved to state with controller
      tableController.sortingList = state.sortingList;
      return RefreshIndicator(
        child: Scaffold(
          backgroundColor: MyColors.mainCanvas,
          body: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GraphManagementTab(tableController: tableController, data: (state).tableData.sublist(1)),
                    Row(
                      children: [
                        SampleRadarChart(data: (state).tableData.sublist(1)),
                        GroupColumnChart(data: (state).tableData.sublist(1)),
                      ]
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            ColumnChart(data: (state).tableData.sublist(1)),
                          ],
                        ),
                        Column(
                          children: [
                            SkillBoxChart(data: (state).tableData.sublist(1)),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                CircularChart(data: (state).tableData.sublist(1))
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            PyramidChart(data: (state).tableData.sublist(1)),
                          ],
                        ),
                      ],
                    ),
                  ]
              ),
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
