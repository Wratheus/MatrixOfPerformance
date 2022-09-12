// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/widgets/new_table_fill_dialog.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/app_ui_modals.dart';
import '../../../../components/sample_error_dialog.dart';
import '../../../../components/sample_text_field.dart';

class NewTableDialog extends StatelessWidget {
  List<dynamic>? tableValues;
  NewTableDialog({Key? key, required context, required this.tableValues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController tableNameTextController = TextEditingController();
    TextEditingController columnAmountTextController = TextEditingController();
    bool tableAlreadyExist = false;
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Create new table 🧵", style: whiteTextColor),
        content: SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                SampleTextField(textController: tableNameTextController, labelText: "Table name", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                const SizedBox(height: 10),
                SampleTextField(textController: columnAmountTextController, labelText: "Amount of columns", hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250,  textInputFormatters: [FilteringTextInputFormatter.digitsOnly], inputType: TextInputType.number,)
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              child: Text("OK", style: whiteTextColor),
              onPressed: () =>
              {
                Navigator.pop(context),
                for(int i = 0; i < tableValues!.length; i++) {
                  if (tableValues![i]['table_name'] == tableNameTextController.text){
                    tableAlreadyExist = true
                  }
                },
                if(tableNameTextController.text.isEmpty){
                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'No table name or columns values provided.')) // wrong values
                } else if(int.parse(columnAmountTextController.text) >= 50){                                                      // hard cap
                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'wrong columns value.')) // wrong values
                } else if(tableAlreadyExist == true){
                  AppUI.showMaterialModalDialog(context: context, child: SampleErrorDialog(errorMessage: 'Table with such name is already exist.')) // wrong values
                }
                else
                  {
                    AppUI.showMaterialModalDialog(context: context, child: NewTableFillDialog(context: context, tableName: tableNameTextController.text, newTableColumnsAmount: int.parse(columnAmountTextController.text))) // to column names dialog
                  }
              }
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
