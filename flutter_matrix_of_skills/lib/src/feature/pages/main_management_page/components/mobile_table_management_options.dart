import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/app_ui_modals.dart';
import '../../../components/dialogs/sample_error_dialog.dart';
import '../../../components/sample_elevated_button.dart';
import '../../../cubit/user_data/user_data_cubit.dart';
import 'dialogs/copy_table_dialog.dart';
import 'dialogs/delete_table_dialog.dart';
import 'dialogs/new_table_dialog.dart';

class MobileTableManagementOptions extends StatelessWidget {
  final TableController tableController;

  const MobileTableManagementOptions({Key? key, required this.tableController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      List<String> values = [];
      for (int i = 0; i < (state as UserDataLoadedState).values.length; i++) {
        values.add(state.values[i]['table_name']);
      }
      return SampleStyleContainer(
        child: Row(
          children: [
            const SizedBox(width: 5),
            Expanded(
              child: SampleElevatedButton(
                  onPressed: () =>
                  {
                    AppUI.showMaterialModalDialog(context: context,
                        child: NewTableDialog(context: context,
                            tableValues: (state).values,
                            tableController: tableController)),
                  },
                  child: Text("New", style: whiteTextColor)),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: SampleElevatedButton(
                  onPressed: () =>
                  {
                    (tableController.selectedValue != null) ?
                    AppUI.showMaterialModalDialog(context: context,
                        child: DeleteTableDialog(
                            tableName: tableController.selectedValue!,
                            context: context,
                            tableController: tableController))
                        :
                    AppUI.showMaterialModalDialog(context: context,
                        child: SampleErrorDialog(
                            errorMessage: 'No table selected.'))
                  },
                  child: Text("Del", style: whiteTextColor)),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: SampleElevatedButton(
                  onPressed: () =>
                  {
                    AppUI.showMaterialModalDialog(context: context,
                        child: CopyTableDialog(context: context,
                            tableController: tableController,
                            allUserTables: (state)
                                .allUserTables,
                            values: values))
                  },
                  child: Text("Copy", style: whiteTextColor)),
            ),
          ],
        ),
      );
    });
  }
}
