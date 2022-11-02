import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/management_tab/graph_management_tab.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/circular_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/group_col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/skillbox_chart.dart';

import '../../../../core/constants/constants.dart';
import '../../../cubit/user_data/user_data_cubit.dart';
import '../../main_management_page/components/group_table_view_controller.dart';
import '../components/widgets/charts/group_radar_chart.dart';

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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GraphManagementTab(tableController: tableController, data: (state).allUserTables),
                  Row(
                    children: [
                      GroupRadarChart(data: (state).tableData.sublist(1)),
                    ]
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                      GroupColumnChart(data: (state).tableData.sublist(1)),
                      ]
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        ColumnChart(data: (state).tableData.sublist(1)),
                        ((state).tableData.sublist(1)[0].keys.length > 6) ? Container() :  SkillBoxChart(data: (state).tableData.sublist(1)),
                        CircularChart(data: (state).tableData.sublist(1)),
                      ],
                    ),
                  ),
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
