// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_disable_glow_effect.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';

// Group Management Dialog Builder
class EditRowFillDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> tableValues;
  String? tableName;
  Map<String, dynamic> match;


  Future<bool> editRowFillAction({required List<TextEditingController> textControllers, required context}) async {
    List<Map<String, dynamic>> newTableValues = []; // fix save in for loop

    for(int i = 0; i < textControllers.length; i++) { // id skip i=1
      if(textControllers[i].text.isNotEmpty) {
        if(i == 0){
          match[match.keys.elementAt(i+1)] = textControllers[i].text; // name to string
        }else {
          match[match.keys.elementAt(i+1)] = int.parse(textControllers[i].text).round(); // skill values
        }
      }else{ // no value provided
        match[match.keys.elementAt(i+1)] = 0;
      }
    }
    for (Map<String, dynamic> element in tableValues) {
      if (element['id'] == match['id']) {
        newTableValues.add(match);
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
      {Key? key, required context, required this.tableValues, required this.tableName, required this.tableController, required this.match}) : super(key: key);

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
                child: DisableGlowEffect(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: match.length,
                      itemBuilder: (BuildContext context, index) {
                        if(index == 0) {
                          return const SizedBox();
                        }else{
                          textControllers.add(TextEditingController(text: match.values.elementAt(index).toString()));
                          return Column(
                            children: [
                              const SizedBox(height: 5),
                              SampleTextField(
                                  labelText: '${match.keys.elementAt(index)} value:',
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