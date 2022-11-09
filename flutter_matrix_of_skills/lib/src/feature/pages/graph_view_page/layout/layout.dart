import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/management_tab/components/group_filter_widget.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/circular_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/group_col_chart.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/graph_view_page/components/widgets/charts/skillbox_chart.dart';

import '../../../../core/constants/constants.dart';
import '../../../cubit/user_data/user_data_cubit.dart';
import '../../main_management_page/components/group_drop_down_menu.dart';
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

      List<Map<String, dynamic>> selectedTable = <Map<String, dynamic>>[{}];
      tableController.selectedValue ??= state.allUserTables[0]['table_name']; // if table is not selected pick first one
      for (Map<String, dynamic> element in state.allUserTables) { // fill name list
        if (element['table_name'] == tableController.selectedValue) {
          selectedTable = element['table'].sublist(1);
        }
      }

      final double radarHeight =  selectedTable.length >= 5 ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.5;
      final double max = maxValue(state.tableData.sublist(1));
      return RefreshIndicator(
        child: Scaffold(
          backgroundColor: MyColors.mainCanvas,
          body: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SampleStyleContainer(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Table ", style: whiteTextColor),
                          const SizedBox(width: 5),
                          Expanded(child: GroupDropDownMenu(tableController: tableController, isExpanded: true, backgroundColor: Colors.transparent),)
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SampleStyleContainer(child: GroupFilterWidget(data: (state).allUserTables, tableController: tableController, height: radarHeight)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SampleStyleContainer(
                                    child: GroupRadarChart(data: (state).tableData.sublist(1), maxValue: max.round(), height: radarHeight,)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SampleStyleContainer(
                        child: RawScrollbar(
                          trackColor: MyColors.mainBeige,
                          trackVisibility: true,
                          timeToFade: const Duration(minutes: 5),
                          thickness: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      Text(state.tableControllerSelectedValue?? state.allUserTables[0]['table_name'], style: const TextStyle(color: MyColors.mainBeige, fontSize: 22, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  GroupColumnChart(data: (state).tableData.sublist(1)),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                        children: (state).tableData.sublist(1).map(<Widget>(Map<String, dynamic>person){
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SampleStyleContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      Text(person['name'], style: const TextStyle(color: MyColors.mainBeige, fontSize: 22, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: ColumnChart(data: person, maxValue: max)),
                                      ((state).tableData.sublist(1)[0].keys.length > 6) ? Container() :  Expanded(child: SkillBoxChart(data: person, maxValue: max)),
                                      Expanded(child: CircularChart(data: person)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }<Widget>).toList()
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