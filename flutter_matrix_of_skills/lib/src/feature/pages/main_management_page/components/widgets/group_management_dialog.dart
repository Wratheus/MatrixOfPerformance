// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/services/app_ui_modals.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';

class GroupManagementDialog extends StatelessWidget {
  bool? newTable;
  bool? newRow;
  bool? newColumn;

  String? newTableName;
  int? newTableColumnsAmount;
  GroupManagementDialog({Key? key, required context, this.newRow, this.newTable, this.newColumn, this.newTableColumnsAmount, this.newTableName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (newTable == true) {
      TextEditingController tableNameTextController = TextEditingController();
      TextEditingController columnAmountTextController = TextEditingController();
      return AlertDialog(
          backgroundColor: MyColors.mainInnerColor,
          title: Text("🧵 Create new table", style: whiteTextColor),
          content: SizedBox(
            height: 140,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Enter the name", style: whiteTextColor),
                  const SizedBox(height: 5),
                  SampleTextField(textController: tableNameTextController, labelText: "Table name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor),
                  const SizedBox(height: 5),
                  SampleTextField(textController: columnAmountTextController, labelText: "Amount of columns", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor)
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK", style: whiteTextColor),
              onPressed: () => {
                Navigator.pop(context),
                AppUI.showMaterialModalDialog(context: context, child: GroupManagementDialog(context: context, newTableName: tableNameTextController.text, newTableColumnsAmount: int.parse(columnAmountTextController.text)),)
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
    if(newColumn == true){
      return Container();
    }
    if(newRow == true){
      return Container();
    }
    if(newTableColumnsAmount != null && newTableName != null){
      List<String> columnNames = [];
      List<TextEditingController> textControllers = [];
      return AlertDialog(
          backgroundColor: MyColors.mainInnerColor,
          title: Text("Please, fill columns name 🥺👍", style: whiteTextColor),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 400,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: newTableColumnsAmount,
                      itemBuilder: (BuildContext context, int index) {
                        textControllers.add(TextEditingController());
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text("Column ${index+1}:", style: whiteTextColor),
                                const SizedBox(width: 5),
                                SampleTextField(labelText: 'value', textColor: whiteTextColor, hideText: false, textController: textControllers[index], borderColor: MyColors.mainBeige),
                              ],
                            ),
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
                await App.supaBaseController?.insertNewTable(newTableName: newTableName!, columns: columnNames, context: context),
                Navigator.pop(context)
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
    else {
      return Container();
    }
  }
}
