// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/services/app_ui_modals.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_alert_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';

// Group Management Dialog Builder
class GroupManagementDialog extends StatelessWidget {
  bool? newTable;
  bool? newRow;
  bool? newColumn;
  bool? deleteTable;

  String? tableName;
  int? newTableColumnsAmount;
  GroupManagementDialog({Key? key, required context, this.newRow, this.newTable, this.newColumn, this.newTableColumnsAmount, this.deleteTable, this.tableName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // new table creation dialog
    if (newTable == true) {
      TextEditingController tableNameTextController = TextEditingController();
      TextEditingController columnAmountTextController = TextEditingController();
      return AlertDialog(
          backgroundColor: MyColors.mainInnerColor,
          title: Text("Create new table 🧵", style: whiteTextColor),
          content: SizedBox(
            height: 135,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SampleTextField(textController: tableNameTextController, labelText: "Table name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                  const SizedBox(height: 10),
                  SampleTextField(textController: columnAmountTextController, labelText: "Amount of columns", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250)
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK", style: whiteTextColor),
              onPressed: () => {
                Navigator.pop(context),
                if(tableNameTextController.text.isNotEmpty && int.parse(columnAmountTextController.text) > 0){
                  AppUI.showMaterialModalDialog(context: context, child: GroupManagementDialog(context: context, tableName: tableNameTextController.text, newTableColumnsAmount: int.parse(columnAmountTextController.text)))
                }
                else{
                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table name or columns provided'))
                }
              },
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
    // new columns list for new table
    if(newTableColumnsAmount != null && tableName != null){
      List<String> columnNames = [];
      List<TextEditingController> textControllers = [];
      return AlertDialog(
          backgroundColor: MyColors.mainInnerColor,
          title: Text("Please, fill headers 🥺👍", style: whiteTextColor),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: newTableColumnsAmount,
                      itemBuilder: (BuildContext context, int index) {
                        textControllers.add(TextEditingController());
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            SampleTextField(labelText: 'Column ${index+1}:', textColor: whiteTextColor, hideText: false, textController: textControllers[index], borderColor: MyColors.mainBeige, width: 250),
                          ],
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK", style: whiteTextColor),
              onPressed: () async => {
                for(int i = 0; i < textControllers.length; i++) columnNames.add(textControllers[i].text),
                await App.supaBaseController?.insertNewTable(tableName: tableName!, columns: columnNames, context: context),
                Navigator.pop(context),
                AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success',))
              },
            ),
            TextButton(
              child: Text("Cancel", style: whiteTextColor),
              onPressed: () => {
                Navigator.pop(context)
              },
            )
          ]
      );
    }
    // delete table dialog
    if(deleteTable == true && tableName != null) {
      return AlertDialog(
          backgroundColor: MyColors.mainInnerColor,
          title: Text('Delete table "$tableName"? 🥺', style: whiteTextColor),

          content: SizedBox(
            height: 50,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: Text("Are you sure you want to delete $tableName", style: whiteTextColor)),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK", style: whiteTextColor),
              onPressed: () async =>
              {
                await App.supaBaseController?.deleteTable(tableName: tableName!, context: context),
                Navigator.pop(context),
                AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success',))
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              child: Text("Cancel", style: whiteTextColor),
              onPressed: () =>
              {
                Navigator.pop(context),
              },
            )
          ]
      );
    }
    // add new column dialog
    if(newColumn == true){
      return Container();
      //                AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success',));
    }
    // add new row dialog
    if(newRow == true){
      return Container();
      //                AppUI.showMaterialModalDialog(context: context, child: SampleAlertDialog(alertMessageStr: 'Done', tittleStr: 'Success',));
    }
    else {
      return SampleErrorDialog(errorMessage: 'Can\'t perform action');
    }
  }
}
