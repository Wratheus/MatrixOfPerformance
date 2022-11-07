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

class CopyTableDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> allUserTables;
  List<String> values;
  String? tableName;


  Future<bool> copyTable({required List<Map<String, dynamic>> allUserTables, required context, required String tableToCopy, required TextEditingController newTableNameTextController, required String? tableName}) async {
    bool newTableExist = false;
    int? indexOfTable;
    List<Map<String, dynamic>> tableValues; // new table that will be copied

    for(int i = 0; i < allUserTables.length; i++){
      if(allUserTables[i]['table_name'] == tableToCopy){
        indexOfTable = i;
      }
      if(allUserTables[i]['table_name'] == newTableNameTextController.text){
        newTableExist = true;// check if new table name already exist
      }
    }

    if(newTableNameTextController.text.isEmpty){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table name or new table name was not provided.')); // wrong values
      return false;
    }else if(newTableExist == true){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: "Table with such name is already exist.")); // such column does not exist
      return false;
    }else{
      tableValues = allUserTables[indexOfTable!]['table']; // select picked table from userTables
      await App.supaBaseController.insertNewTable(table: 'user_tables', // update table if match was found
          tableName: newTableNameTextController.text,
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
  CopyTableDialog({Key? key, required context, required this.allUserTables, required this.tableController, required this.values}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SampleDropDownMenu dropDownMenu = SampleDropDownMenu(values: values, isExpanded: true);
    TextEditingController newTableNameTextController = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Copy table 🧵", style: whiteTextColor),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: dropDownMenu),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: SampleTextField(textController: newTableNameTextController, labelText: "New table name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 200)),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {copyTable(tableName: tableName, allUserTables: allUserTables, context: context, tableToCopy: dropDownMenu.selectedValue, newTableNameTextController: newTableNameTextController);},
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