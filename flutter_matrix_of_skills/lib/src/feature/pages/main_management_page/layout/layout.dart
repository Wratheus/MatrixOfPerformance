import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

import '../../../cubit/user_data/user_data_cubit.dart';
import '../components/group_management_tab.dart';
import '../components/group_table_view.dart';
import '../components/group_table_view_controller.dart';

class TableManagementPageLayout extends StatelessWidget {
  final TableController tableController = TableController();
  TableManagementPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              GroupManagementTab(tableController: tableController),
              const GroupTableView(),
            ]
          ),
        ),
      ),
      onRefresh: () =>
          context.read<UserDataCubit>()
              .reloadUserData(),
    );
  }
}
