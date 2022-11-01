// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';
import '../../../../components/sample_text_field.dart';

class CopyTableDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> allUserTables;
  String? tableName;


  Future<bool> copyTable({required List<Map<String, dynamic>> allUserTables, required context, required TextEditingController tableNameTextController, required TextEditingController newTableNameTextController, required String? tableName}) async {
    bool tableExist = false;
    bool newTableExist = false;
    int? indexOfTable;
    List<Map<String, dynamic>> tableValues; // new table that will be copied

    for(int i = 0; i < allUserTables.length; i++){
      if(allUserTables[i]['table_name'] == tableNameTextController.text){
        tableExist = true; // check if such table does exist
        indexOfTable = i;
      }
      if(allUserTables[i]['table_name'] == newTableNameTextController.text){
        newTableExist = true;// check if new table name already exist
      }
    }


    if(tableNameTextController.text.isEmpty || newTableNameTextController.text.isEmpty){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table name or new table name was not provided.')); // wrong values
      return false;
    }
    if(tableExist == false || indexOfTable == null){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table with such name does not exist')); // such column does not exist
      return false;
    }else if(newTableExist == true){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: "Table with such name is already exist.")); // such column does not exist
      return false;
    }else{
      tableValues = allUserTables[indexOfTable]['table']; // select picked table from userTables
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
  CopyTableDialog({Key? key, required context, required this.allUserTables, required this.tableController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController tableNameTextController = TextEditingController();
    TextEditingController newTableNameTextController = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Copy table 🧵", style: whiteTextColor),
        content: SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                SampleTextField(textController: tableNameTextController, labelText: "Table to copy", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                const SizedBox(height: 10),
                SampleTextField(textController: newTableNameTextController, labelText: "New table name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {copyTable(tableName: tableName, allUserTables: allUserTables, context: context, tableNameTextController: tableNameTextController, newTableNameTextController: newTableNameTextController);},
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