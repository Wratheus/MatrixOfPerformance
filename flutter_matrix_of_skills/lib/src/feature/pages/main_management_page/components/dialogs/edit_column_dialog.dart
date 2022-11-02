// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_drop_down_menu.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';
import '../../../../components/sample_text_field.dart';

class EditColumnDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> tableValues;
  String? tableName;

  Future<bool> editColumn({required List<Map<String, dynamic>> tableValues, required context, required String columnName, required TextEditingController newColumnNameTextController, required String? tableName}) async {
    if((tableValues[0]).containsKey(newColumnNameTextController.text) == true){// check if new column does already defined in table
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: "New skill name rejected: it's already defined in table")); // such column does not exist
      return false;
    }else{
      for(int i = 0; i < tableValues.length; i++){
        var currentKeyValueSave = tableValues[i][columnName]; // save old value
        (tableValues[i]).remove(columnName); // remove old key
        (tableValues[i])[newColumnNameTextController.text] = currentKeyValueSave; // add old value to new key
      }

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
  }

// init
  EditColumnDialog({Key? key, required context, required this.tableValues, required this.tableName, required this.tableController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SampleDropDownMenu dropDownMenu = SampleDropDownMenu(values: tableValues[0].keys.toList().sublist(2), isExpanded: false);
    TextEditingController newColumnNameTextController = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Rename skill 🧵", style: whiteTextColor),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: dropDownMenu),
                ],
              ),
              Row(
                children: [
                  Expanded(child: SampleTextField(textController: newColumnNameTextController, labelText: "New skill name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {editColumn(tableName: tableName, tableValues: tableValues, columnName: dropDownMenu.selectedValue, newColumnNameTextController: newColumnNameTextController, context: context);},
            child: Text("OK", style: whiteTextColor),
          ),
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