// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';
import '../../../../components/sample_text_field.dart';

class EditColumnDialog extends StatelessWidget {

  final TableController tableController;
  List<dynamic> tableValues;
  String? tableName;


  Future<bool> editColumn({required List<dynamic> tableValues, required context, required TextEditingController columnNameTextController, required TextEditingController newColumnNameTextController, required String? tableName}) async {
    bool columnExist = false;
    bool newColumnExist = false;
    if((tableValues[0] as Map).containsKey(columnNameTextController.text) == true){columnExist = true;} // check if column does already defined in table
    if((tableValues[0] as Map).containsKey(newColumnNameTextController.text) == true){columnExist = true;} // check if new column does already defined in table

    if(columnNameTextController.text == 'id' || newColumnNameTextController.text == 'id' || columnNameTextController.text.isEmpty || newColumnNameTextController.text.isEmpty){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Removing id or leaving blank space in column name restricted.')); // wrong values
      return false;
    }
   if(columnExist == false){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Such column name does not exist.')); // such column does not exist
      return false;
    }else if(newColumnExist == true){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: "New column name rejected: it's already defined in table")); // such column does not exist
      return false;
    }else{
      // TODO: fix order replacement, check dart functional
      for(int i = 0; i < tableValues.length; i++){
        var currentKeyValueSave = (tableValues[i] as Map)[columnNameTextController.text]; // save old value
        (tableValues[i] as Map).remove(columnNameTextController.text); // remove old key
        (tableValues[i] as Map)[newColumnNameTextController.text] = currentKeyValueSave; // add old value to new key
      }

      await App.supaBaseController?.updateTable(table: 'user_tables', // update table if match was found
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
    TextEditingController columnNameTextController = TextEditingController();
    TextEditingController newColumnNameTextController = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Rename column 🧵", style: whiteTextColor),
        content: SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                SampleTextField(textController: columnNameTextController, labelText: "Old column name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                const SizedBox(height: 10),
                SampleTextField(textController: newColumnNameTextController, labelText: "New column name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {editColumn(tableName: tableName, tableValues: tableValues, columnNameTextController: columnNameTextController, newColumnNameTextController: newColumnNameTextController, context: context);},
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