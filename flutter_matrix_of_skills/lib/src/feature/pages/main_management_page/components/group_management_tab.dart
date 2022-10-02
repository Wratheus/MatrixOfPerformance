import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/dialogs/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/copy_table_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/delete_column_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/delete_row_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/edit_column_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/edit_row_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/new_column_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/responsive_layout.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/app_ui_modals.dart';
import '../cubit/main_management_page_cubit.dart';
import 'dialogs/delete_table_dialog.dart';
import 'dialogs/new_row_dialog.dart';
import 'dialogs/new_table_dialog.dart';
import 'group_drop_down_menu.dart';
import 'group_table_view_controller.dart';

class GroupManagementTab extends StatelessWidget {
  final TableController tableController;
  const GroupManagementTab({Key? key, required this.tableController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(builder: (context, state) {

      tableController.cubitContext = context; // share cubit context to tableController to have ability to update
      tableController.selectedValue = (state as MainManagementPageLoadedState).tableControllerSelectedValue; // share selected value if it was saved to state with controller

      return (ResponsiveLayout.desktopPlatformSizeCheck()) ?
      // Desktop Layout
      Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SampleStyleContainer(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Select table: ", style: whiteTextColor),
                          Expanded(child: GroupDropDownMenu(tableController: tableController)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: (state).values, tableController: tableController)),
                                },
                                child: Text("New", style: whiteTextColor)),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  (tableController.selectedValue != null) ?
                                  AppUI.showMaterialModalDialog(context: context, child: DeleteTableDialog(tableName: tableController.selectedValue!, context: context, tableController: tableController))
                                      :
                                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                },
                                child: Text("Delete", style: whiteTextColor)),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  AppUI.showMaterialModalDialog(context: context, child: CopyTableDialog(context: context, tableController: tableController, allUserTables: state.allUserTables))
                                },
                                child: Text("Copy", style: whiteTextColor)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SampleStyleContainer(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                  AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                                  :
                                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                },
                                child: Text("Add row", style: whiteTextColor)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                  AppUI.showMaterialModalDialog(context: context, child: NewColumnDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                                      :
                                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                },
                                child: Text("Add column", style: whiteTextColor)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SampleStyleContainer(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                  AppUI.showMaterialModalDialog(context: context, child: DeleteRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                      :
                                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                },
                                child: Text("Delete row", style: whiteTextColor)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                  AppUI.showMaterialModalDialog(context: context, child: DeleteColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                      :
                                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                },
                                child: Text("Delete column", style: whiteTextColor)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SampleStyleContainer(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                  AppUI.showMaterialModalDialog(context: context, child: EditRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                      :
                                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                },
                                child: Text("Edit row", style: whiteTextColor)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()=>{
                                  (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                  AppUI.showMaterialModalDialog(context: context, child: EditColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                      :
                                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                },
                                child: Text("Edit column", style: whiteTextColor)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ) :
      // Mobile Layout
      Column(
        children: [
          SampleStyleContainer(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select table", style: whiteTextColor),
                  Row(
                    children: [
                      Expanded(child: GroupDropDownMenu(tableController: tableController)),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: ()=>{
                              AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: (state).values, tableController: tableController)),
                            },
                            child: Text("New", style: whiteTextColor)),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: ()=>{
                              (tableController.selectedValue != null) ?
                              AppUI.showMaterialModalDialog(context: context, child: DeleteTableDialog(tableName: tableController.selectedValue!, context: context, tableController: tableController))
                                  :
                              AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                            },
                            child: Text("Delete", style: whiteTextColor)),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: ()=>{
                              AppUI.showMaterialModalDialog(context: context, child: CopyTableDialog(context: context, tableController: tableController, allUserTables: state.allUserTables))
                            },
                            child: Text("Copy", style: whiteTextColor)),
                      ),
                    ],
                  ),
                ]),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Add row", style: whiteTextColor)
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: NewColumnDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Add column", style: whiteTextColor)
                  ),
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: DeleteRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Delete row", style: whiteTextColor)
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: DeleteColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Delete column", style: whiteTextColor)
                  ),
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: EditRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Edit row", style: whiteTextColor)
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: EditColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Edit column", style: whiteTextColor)
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
