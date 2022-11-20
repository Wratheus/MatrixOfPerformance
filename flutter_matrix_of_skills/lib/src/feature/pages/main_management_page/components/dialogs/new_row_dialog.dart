// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_disable_glow_effect.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';

// Group Management Dialog Builder
class NewRowDialog extends StatelessWidget {

  final TableController tableController;
  List<Map<String, dynamic>> tableValues;
  String? tableName;


  void newRowAction({required List<TextEditingController> textControllers, required Map<String, dynamic> newRow, required context}) async {
    newRow[(tableValues.last).keys.elementAt(0)] = (tableValues.last).values.elementAt(0) + 1; // increment id and save as string
    for(int i = 0; i < textControllers.length; i++) {
      if(textControllers[i].text.isNotEmpty) {
        if(i == 0) {
          newRow[(tableValues[0]).keys.elementAt(i+1)] = textControllers[i].text;
        }else if(isDigit(textControllers[i].text)){
          newRow[(tableValues[0]).keys.elementAt(i+1)] = int.parse(textControllers[i].text).round();
        }else{
          Navigator.pop(context);
          AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Skill values is not integer.')); // default value is not int
          return;
        }
      }else{
        Navigator.pop(context);
        AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Empty value.')); // default value is not int
        return;
      }
    }
    tableValues.add(newRow);
    await App.supaBaseController.updateTable(table: 'user_tables',
        tableName: tableName,
        columns: tableValues,
        context: context
    );
    await tableController.update(tableName: tableName, selectedValue: tableController.selectedValue);
  }
  NewRowDialog(
      {Key? key, required context, required this.tableValues, required this.tableName, required this.tableController})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newRow = {};
    List<TextEditingController> textControllers = [];
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Please, fill new row 🧵", style: whiteTextColor, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 300,
                child: DisableGlowEffect(
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
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {newRowAction(textControllers: textControllers, newRow: newRow, context: context);},
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