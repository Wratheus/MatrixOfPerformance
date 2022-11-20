// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/services/app_ui_disable_glow_effect.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/dialogs/sample_alert_dialog.dart';
import '../../../../components/dialogs/sample_error_dialog.dart';
import '../../../../components/sample_text_field.dart';

class NewColumnDialog extends StatelessWidget {
  List<TextEditingController> textControllers = [];
  List<Map<String, dynamic>> tableValues;
  String? tableName;
  final TableController tableController;

  Future<bool> addNewColumn({required List<Map<String, dynamic>> tableValues, required context, required TextEditingController columnNameTextController, required String? tableName, required List<TextEditingController> textControllers, required TextEditingController defaultValueTextController}) async {
    bool columnAlreadyExist = false;
    if((tableValues[0]).containsKey(columnNameTextController.text) == true){columnAlreadyExist = true;} // if such column name is already defined

    if(columnNameTextController.text.isEmpty){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Wrong skill value.')); // wrong values
      return false;
    } else if(columnAlreadyExist == true){
      Navigator.pop(context);
      AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Such skill is already exist.')); // wrong values
      return false;
    }else{
      if(!isDigit(defaultValueTextController.text)) defaultValueTextController.text = '0';
      for(int i = 0; i < textControllers.length; i++){
        if(isDigit(textControllers[i].text)){
          tableValues[i][columnNameTextController.text] = int.parse(textControllers[i].text).round(); // add such key to every Row of table and give it text variable if it was provided
        }else{
          tableValues[i][columnNameTextController.text] = int.parse(defaultValueTextController.text).round();
        }
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
  NewColumnDialog({Key? key, required context, required this.tableValues, required this.tableName, required this.tableController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController columnNameTextController = TextEditingController();
    TextEditingController defaultColumnValue = TextEditingController();
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Add new skill 🧵", style: whiteTextColor, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SampleTextField(textController: columnNameTextController, labelText: "New skill name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              const SizedBox(height: 5),
              SampleTextField(textController: defaultColumnValue, labelText: "default skill value", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
              SizedBox(
                width: 250,
                height: tableValues.length < 3 ? 50 : tableValues.length > 5 ? 250 : 150,
                child: DisableGlowEffect(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tableValues.length,
                      itemBuilder: (BuildContext context, index) {
                        if(index == 0) {
                          textControllers.add(TextEditingController());
                          return const SizedBox(height: 5,);
                        }else{
                          textControllers.add(TextEditingController());
                          return Column(
                            children: [
                              const SizedBox(height: 5),
                              SampleTextField(
                                  labelText: "${tableValues[index]['name']} value:",
                                  textColor: whiteTextColor,
                                  hideText: false,
                                  textController: textControllers[index],
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
            onPressed: () {addNewColumn(textControllers: textControllers, tableName: tableName, tableValues: tableValues, columnNameTextController: columnNameTextController, defaultValueTextController: defaultColumnValue, context: context);},
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