import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/services/app_ui_disable_glow_effect.dart';
import 'package:flutter_matrix_of_skills/src/core/services/custom_scroll_behavior.dart';
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
import '../components/widgets/mobile_widgets/drop_down_tab.dart';
class GraphViewPageLayout extends StatelessWidget {
  final TableController tableController = TableController();
  GraphViewPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      List<Widget> slidePageList = [];
      tableController.cubitContext = context; // share cubit context to tableController to have ability to update
      tableController.selectedValue = (state as UserDataLoadedState).tableControllerSelectedValue; // share selected value if it was saved to state with controller
      tableController.sortingList = state.sortingList;
      tableController.selectedValue ??= state.allUserTables[0]['table_name']; // if table is not selected pick first one

      final double radarHeight = (Platform.isAndroid || Platform.isIOS) ?
      MediaQuery.of(context).size.height * 0.8
                            :
      MediaQuery.of(context).size.height * 0.5;

      final double max = maxValue(state.tableData.sublist(1));

      if  (Platform.isAndroid || Platform.isIOS) { // mobile PageView for this layout
          slidePageList = <Widget>[];
          slidePageList.add(
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GroupRadarChart(data: (state).tableData.sublist(1), height: MediaQuery.of(context).size.height * 0.44),
              )
          );
          slidePageList.add(
              DropDownChartMenu(personList: state.tableData.sublist(1), max: max)
          );

      }

      return Platform.isWindows ? Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Table ", style: whiteTextColor),
                        const SizedBox(width: 5),
                        Expanded(child: GroupDropDownMenu(tableController: tableController, isExpanded: true, backgroundColor: Colors.transparent),)
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SampleStyleContainer(
                            child: GroupFilterWidget(data: (state).allUserTables, tableController: tableController, height: radarHeight, width: MediaQuery.of(context).size.width * 0.35)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SampleStyleContainer(
                              child: GroupRadarChart(data: (state).tableData.sublist(1), height: radarHeight,)
                          ),
                        ),
                      ),
                    ],
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
      ) // mobile layout
          :
      Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: Stack(
          children: [
            DisableGlowEffect(
              child: PageView(
                scrollBehavior: CustomScrollBehavior(),
                children: slidePageList
              ),
            ),
            DisableGlowEffect(
              child: DraggableScrollableSheet(
                  initialChildSize: 0.13,
                  maxChildSize: 0.75,
                  minChildSize: 0.13 ,
                  builder: (context, scrollController) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.customBlack.withOpacity(0.35),
                            blurRadius: 4,
                          ),
                        ],
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        color: MyColors.mainInnerColor,
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Container(width: 200, height: 2, color: MyColors.mainBeige.withOpacity(0.3)),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Table ", style: whiteTextColor),
                                const SizedBox(width: 5),
                                Expanded(child: GroupDropDownMenu(tableController: tableController, isExpanded: true, backgroundColor: Colors.transparent),)
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(child: GroupFilterWidget(data: (state).allUserTables, tableController: tableController, height: MediaQuery.of(context).size.height * 0.5, width: MediaQuery.of(context).size.height * 0.35)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ]
        ),
      );
    });
  }
}