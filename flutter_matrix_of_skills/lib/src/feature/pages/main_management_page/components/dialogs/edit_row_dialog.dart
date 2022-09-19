// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/dialogs/edit_row_fill_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';

// Group Management Dialog Builder
class EditRowDialog extends StatelessWidget {

  final TableController tableController;
  List<dynamic> tableValues;
  String? tableName;
  int? id;


  Future<bool> editRowAction({required String rowID, required context, required List<dynamic> tableValues, required String tableName}) async {
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
        Navigator.pop(context);
        AppUI.showMaterialModalDialog(context: context, child: EditRowFillDialog(context: context, tableValues: tableValues, tableName: tableName, rowID: id!, tableController: tableController));
        return true;
      } else{
        Navigator.pop(context);
        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table does not have that id match.')); // no id match found
        return false;
      }
    }catch(e){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table does not have that id match.')); // no id match found
      return false;
    }
  }

  EditRowDialog({Key? key, required context, required this.tableValues, required this.tableName, required this.tableController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Edit row 🧵", style: whiteTextColor),
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
              onPressed: () {editRowAction(rowID: textController.text, context: context, tableValues: tableValues, tableName: tableName!);},
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