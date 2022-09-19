// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';

// Group Management Dialog Builder
class DeleteRowDialog extends StatelessWidget {

  final TableController tableController;
  List<dynamic> tableValues;
  String? tableName;
  int? id;


  Future<bool> deleteRowAction({required String rowID, required context, required List<dynamic> tableValues}) async {
    Map<String, dynamic>? match;
    try{
      id = int.parse(rowID);
      if(id == 0){ // deleting 0 id header element restricted
        Navigator.pop(context);
        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Restricted id.'));
        return false;
      }
      for (Map<String, dynamic> element in tableValues) {
        if(element['id'] == id) {
          match = element;
        }
      }
      if(match != null)  {
        tableValues.removeWhere((element) => element == match); // delete match id
      } else{
        Navigator.pop(context);
        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table does not have that id match.')); // no id match found
        return false;
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
    }catch(e){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table does not have that id match.')); // no id match found
      return false;
    }
  }


  DeleteRowDialog(
      {Key? key, required context, required this.tableValues, required this.tableName, required this.tableController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Delete row 🧵", style: whiteTextColor),
        content: SizedBox(
          height: 80,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                SampleTextField(textController: textController, labelText: "Enter row ID", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {deleteRowAction(rowID: textController.text, context: context, tableValues: tableValues);},
              child: Text("OK", style: whiteTextColor)
          ),
          TextButton(
            child: Text("Cancel", style: whiteTextColor),
            onPressed: () =>
            {
              Navigator.pop(context)
            },
          )
        ]
    );
  }
}