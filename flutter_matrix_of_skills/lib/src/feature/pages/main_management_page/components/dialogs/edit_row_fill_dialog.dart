// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';

// Group Management Dialog Builder
class EditRowFillDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> tableValues;
  String? tableName;
  int rowID;


  Future<bool> editRowFillAction({required List<TextEditingController> textControllers, required context}) async {
    Map<String, dynamic> editedRow = {};
    List<Map<String, dynamic>> newTableValues = []; // fix save in for loop
    editedRow[(tableValues[0]).keys.elementAt(0)] = rowID; // will be defined in id match block

    for(int i = 0; i < textControllers.length; i++) {
      if(textControllers[i].text.isNotEmpty) {
        editedRow[(tableValues[0]).keys.elementAt(i+1)] = textControllers[i].text;
      } else{
        editedRow[(tableValues[0]).keys.elementAt(i+1)] = null;
      }
    }
    for (Map<String, dynamic> element in tableValues) {
      if (element['id'] == rowID) {
        newTableValues.add(editedRow);

      }else {
        newTableValues.add(element);
      }
    }
    await App.supaBaseController.updateTable(table: 'user_tables', // update table if match was found
        tableName: tableName,
        columns: newTableValues,
        context: context
    );
    await tableController.update(tableName: tableName, selectedValue: tableController.selectedValue);
    Navigator.pop(context);
    AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success'));
    return true;
  }


  EditRowFillDialog(
      {Key? key, required context, required this.tableValues, required this.tableName, required this.rowID, required this.tableController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textControllers = [];
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Please, edit row", style: whiteTextColor),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tableValues[0].length,
                    itemBuilder: (BuildContext context, index) {
                      if(index == 0) {
                        return const SizedBox();
                      }else{
                        textControllers.add(TextEditingController());
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            SampleTextField(
                                labelText: '${(tableValues[0]).keys.elementAt(index)} value:',
                                textColor: whiteTextColor,
                                hideText: false,
                                textController: textControllers[index-1],
                                borderColor: MyColors.mainBeige,
                                width: 250),
                          ],
                        );
                      }
                    }
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {editRowFillAction(textControllers: textControllers, context: context);},
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