// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';
import '../../../../components/sample_text_field.dart';

class DeleteColumnDialog extends StatelessWidget {

  final TableController tableController;
  List<dynamic> tableValues;
  String? tableName;


  Future<bool> deleteColumn({required List<dynamic> tableValues, required context, required TextEditingController columnNameTextController, required String? tableName}) async {
    bool columnExist = false;

    if((tableValues[0] as Map).containsKey(columnNameTextController.text) == true){columnExist = true;} // check if column does exist
    if(columnNameTextController.text == 'id'){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Removing id column restricted.')); // wrong values
      return false;
    }
    if(columnNameTextController.text.isEmpty){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Wrong column name value.')); // wrong values
      return false;
    } else if(columnExist == false){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Such column name does not exist.')); // such column does not exist
      return false;
    }else{
      for(int i = 0; i < tableValues.length; i++){
        (tableValues[i] as Map).remove(columnNameTextController.text); // remove Key and value pair by key
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
  DeleteColumnDialog({Key? key, required context, required this.tableValues, required this.tableName, required this.tableController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController columnNameTextController = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Delete column 🧵", style: whiteTextColor),
        content: SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                SampleTextField(textController: columnNameTextController, labelText: "Column name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {deleteColumn(tableName: tableName, tableValues: tableValues, columnNameTextController: columnNameTextController, context: context);},
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