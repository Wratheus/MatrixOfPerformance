// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_drop_down_menu.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';

class DeleteColumnDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> tableValues;
  String? tableName;


  Future<bool> deleteColumn({required List<Map<String, dynamic>> tableValues, required context, required String columnName, required String? tableName}) async {
      for(int i = 0; i < tableValues.length; i++) {
        (tableValues[i]).remove(columnName);
      } // remove Key and value pair by key

      await App.supaBaseController.updateTable(table: 'user_tables', // update table if match was found
          tableName: tableName,
          columns: tableValues,
          context: context
      );
      await tableController.update(tableName: tableName, selectedValue: tableController.selectedValue);
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success'));
      return true;
    }


// init
  DeleteColumnDialog({Key? key, required context, required this.tableValues, required this.tableName, required this.tableController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SampleDropDownMenu dropDownMenu = SampleDropDownMenu(values: tableValues[0].keys.toList().sublist(2), isExpanded: true);
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Delete skill 🧵", style: whiteTextColor, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text("Select skill to remove:", style: whiteTextColor),
                ],
              ),
              Row(
                children: [
                  Expanded(child: dropDownMenu),
                ],
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {deleteColumn(tableName: tableName, tableValues: tableValues, columnName: dropDownMenu.selectedValue, context: context);},
            child: Text("OK", style: whiteTextColor),
          ),
          const SizedBox(height: 10),
          TextButton(
            child: Text("Cancel", style: whiteTextColor),
            onPressed: () => {
              Navigator.pop(context)
            },
          )
        ]
    );
  }
}