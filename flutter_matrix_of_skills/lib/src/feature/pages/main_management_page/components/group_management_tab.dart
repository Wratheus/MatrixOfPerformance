import 'dart:io';

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

import '../../../../core/constants/constants.dart';
import '../../../../core/services/app_ui_modals.dart';
import '../../../components/sample_elevated_button.dart';
import '../../../cubit/user_data/user_data_cubit.dart';
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
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      List<String> values = [];
      for(int i = 0; i < (state as UserDataLoadedState).values.length; i++){
        values.add(state.values[i]['table_name']);
      }
      return (Platform.isWindows) ?
      // Desktop Layout
      SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: IntrinsicHeight(
            child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        const Spacer(),
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
                        const Spacer(),
                        SampleStyleContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Rows ", style: whiteTextColor),
                              const SizedBox(width: 5),
                              SampleElevatedButton(
                                  onPressed: ()=>{
                                    (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                    AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                                        :
                                    AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                  },
                                  child: Text("Add person", style: whiteTextColor)
                              ),
                              const SizedBox(width: 5),
                              SampleElevatedButton(
                                  onPressed: ()=>{
                                    (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                    AppUI.showMaterialModalDialog(context: context, child: EditRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                        :
                                    AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                  },
                                  child: Text("Edit person", style: whiteTextColor)
                              ),
                              const SizedBox(width: 5),
                              SampleElevatedButton(
                                  onPressed: ()=>{
                                    (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                    AppUI.showMaterialModalDialog(context: context, child: DeleteRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                        :
                                    AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                  },
                                  child: Text("Delete person", style: whiteTextColor)
                              ),
                              const SizedBox(width: 40),
                              Text("Skills ", style: whiteTextColor),
                              const SizedBox(width: 5),
                              SampleElevatedButton(
                                  onPressed: ()=>{
                                    (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                    AppUI.showMaterialModalDialog(context: context, child: NewColumnDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                                        :
                                    AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                  },
                                  child: Text("Add skill", style: whiteTextColor)
                              ),
                              const SizedBox(width: 5),
                              SampleElevatedButton(
                                  onPressed: ()=>{
                                    (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                    AppUI.showMaterialModalDialog(context: context, child: EditColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                        :
                                    AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                  },
                                  child: Text("Edit skill", style: whiteTextColor)
                              ),
                              const SizedBox(width: 5),
                              SampleElevatedButton(
                                  onPressed: ()=>{
                                    (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                                    AppUI.showMaterialModalDialog(context: context, child: DeleteColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                                        :
                                    AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                                  },
                                  child: Text("Delete skill", style: whiteTextColor)
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SampleStyleContainer(
                    child: Column(
                      children: [
                        SampleElevatedButton(
                            onPressed: ()=>{
                              AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: (state).values, tableController: tableController)),
                            },
                            child: Text("New Table", style: whiteTextColor)),
                        const SizedBox(width: 5),
                        SampleElevatedButton(
                            onPressed: ()=>{
                              (tableController.selectedValue != null) ?
                              AppUI.showMaterialModalDialog(context: context, child: DeleteTableDialog(tableName: tableController.selectedValue!, context: context, tableController: tableController))
                                  :
                              AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                            },
                            child: Text("Del Table", style: whiteTextColor)),
                        const SizedBox(width: 5),
                        SampleElevatedButton(
                            onPressed: ()=>{
                              AppUI.showMaterialModalDialog(context: context, child: CopyTableDialog(context: context, tableController: tableController, allUserTables: state.allUserTables, values: values))
                            },
                            child: Text("Copy Table", style: whiteTextColor))
                      ],
                    ),
                  ),
                ]),
          ),
      )
      :
      // Mobile Layout
      SampleStyleContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SampleElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Add person", style: whiteTextColor)
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SampleElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: NewColumnDialog(tableName: tableController.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Add skill", style: whiteTextColor)
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SampleElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: DeleteRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Delete person", style: whiteTextColor)
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SampleElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: DeleteColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Delete skill", style: whiteTextColor)
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SampleElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: EditRowDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Edit person", style: whiteTextColor)
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SampleElevatedButton(
                      onPressed: ()=>{
                        (tableController.selectedValue != null && (state).tableData.isNotEmpty) ?
                        AppUI.showMaterialModalDialog(context: context, child: EditColumnDialog(context: context, tableValues: state.tableData, tableName: tableController.selectedValue, tableController: tableController))
                            :
                        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                      },
                      child: Text("Edit skill", style: whiteTextColor)
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
