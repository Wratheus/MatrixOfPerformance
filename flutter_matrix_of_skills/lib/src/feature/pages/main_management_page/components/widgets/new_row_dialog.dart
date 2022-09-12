// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/services/app_ui_modals.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_alert_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_text_field.dart';

import '../../../../../core/classes/app.dart';
import '../../../../../core/constants/constants.dart';

// Group Management Dialog Builder
class NewRowDialog extends StatelessWidget {
  List<dynamic> tableValues;
  String? tableName;

  NewRowDialog(
      {Key? key, required context, required this.tableValues, required this.tableName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newRow = {};
    List<TextEditingController> textControllers = [];
    return AlertDialog(
        backgroundColor: MyColors.mainInnerColor,
        title: Text("Please, fill new row", style: whiteTextColor),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tableValues[0].length,
                    itemBuilder: (BuildContext context, int index) {
                      textControllers.add(TextEditingController());
                      return Column(
                        children: [
                          const SizedBox(height: 5),
                          SampleTextField(
                              labelText: '${(tableValues[0] as Map).keys.elementAt(index)} value:',
                              textColor: whiteTextColor,
                              hideText: false,
                              textController: textControllers[index],
                              borderColor: MyColors.mainBeige,
                              width: 250),
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
            onPressed: () async =>
            {
              for(int i = 0; i < textControllers.length; i++) {
                if(textControllers[i].text.isNotEmpty) {
                  newRow[(tableValues[0] as Map).keys.elementAt(i)] = textControllers[i].text,
                }
              },
              tableValues.add(newRow),
              print(tableValues),
              await App.supaBaseController?.insertNewRow(table: 'user_tables',
                  tableName: tableName!,
                  columns: tableValues,
                  context: context
              )
            },
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