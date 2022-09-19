import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/dialogs/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
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
    tableController.cubitContext = context;
    GroupDropDownMenu managementTabDropDownMenu = GroupDropDownMenu(tableController: tableController);

    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(builder: (context, state) {
      return (ResponsiveLayout.desktopPlatformSizeCheck()) ?
      // Desktop Layout
      Row(
        children: [
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Select table: ",
                        style: whiteTextColor
                    ),
                    const SizedBox(width: 30),
                    managementTabDropDownMenu,
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: ()=>{
                        AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: (state as MainManagementPageLoadedState).values, tableController: tableController)),
                        },
                        child: Text("New", style: whiteTextColor)),
                    const SizedBox(width: 5),
                    ElevatedButton(
                        onPressed: ()=>{
                          (managementTabDropDownMenu.selectedValue != null) ?
                          AppUI.showMaterialModalDialog(context: context, child: DeleteTableDialog(tableName: managementTabDropDownMenu.selectedValue!, context: context, tableController: tableController))
                              :
                          AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                        },
                        child: Text("Delete", style: whiteTextColor)),
                    // TODO: Copy from another table method later
                    const SizedBox(width: 5),
                    ElevatedButton(
                        onPressed: ()=>{
                        },
                        child: Text("Copy", style: whiteTextColor)),
                  ],
                )
              ],
            ),
          ),
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: managementTabDropDownMenu.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                      :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Add row", style: whiteTextColor)
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: NewColumnDialog(tableName: managementTabDropDownMenu.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Add column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: DeleteRowDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Delete row", style: whiteTextColor)
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: DeleteColumnDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Delete column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: EditRowDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Edit row", style: whiteTextColor)
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: EditColumnDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Edit column", style: whiteTextColor)
                ),
              ],
            ),
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
                      managementTabDropDownMenu,
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: ()=>{
                            AppUI.showMaterialModalDialog(context: context, child: NewTableDialog(context: context, tableValues: (state as MainManagementPageLoadedState).values, tableController: tableController)),
                          },
                          child: Text("New", style: whiteTextColor)),
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: ()=>{
                            (managementTabDropDownMenu.selectedValue != null) ?
                            AppUI.showMaterialModalDialog(context: context, child: DeleteTableDialog(tableName: managementTabDropDownMenu.selectedValue!, context: context, tableController: tableController))
                                :
                            AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                          },
                          child: Text("Delete", style: whiteTextColor)),
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: ()=>{
                            (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty)  ?
                            {}
                                :
                            AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                          },
                          child: Text("Copy", style: whiteTextColor)),
                    ],
                  ),
                ]),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: NewRowDialog(tableName: managementTabDropDownMenu.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Add row", style: whiteTextColor)
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: NewColumnDialog(tableName: managementTabDropDownMenu.selectedValue, context: context, tableValues: state.tableData, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Add column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: DeleteRowDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Delete row", style: whiteTextColor)
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: DeleteColumnDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Delete column", style: whiteTextColor)
                ),
              ],
            ),
          ),
          SampleStyleContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: EditRowDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Edit row", style: whiteTextColor)
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: ()=>{
                      (managementTabDropDownMenu.selectedValue != null && (state as MainManagementPageLoadedState).tableData.isNotEmpty) ?
                      AppUI.showMaterialModalDialog(context: context, child: EditColumnDialog(context: context, tableValues: state.tableData, tableName: managementTabDropDownMenu.selectedValue, tableController: tableController))
                          :
                      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table selected.'))
                    },
                    child: Text("Edit column", style: whiteTextColor)
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
