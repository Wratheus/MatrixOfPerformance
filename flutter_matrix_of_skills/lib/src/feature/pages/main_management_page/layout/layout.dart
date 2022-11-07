import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';

import '../../../cubit/user_data/user_data_cubit.dart';
import '../components/group_drop_down_menu.dart';
import '../components/group_management_tab.dart';
import '../components/group_table_view.dart';
import '../components/group_table_view_controller.dart';
import '../components/mobile_table_management_options.dart';

class TableManagementPageLayout extends StatelessWidget {
  final TableController tableController = TableController();
  TableManagementPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: (Platform.isWindows) ?  SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    GroupManagementTab(tableController: tableController),
                    const GroupTableView(),
                  ]
              )

          ),
        ):
        Column(
          children: [
            Row(
              children: [
                Expanded(child: GroupDropDownMenu(tableController: tableController, isExpanded: true)),
              ],
            ),
            const SizedBox(height: 5),
            MobileTableManagementOptions(tableController: tableController),
            const SizedBox(height: 2),
            SampleStyleContainer(
              height: MediaQuery.of(context).size.height * 0.55,
              child: SingleChildScrollView(
                controller: ScrollController(), child: const GroupTableView()),
            ),
            const Spacer(),
            GroupManagementTab(tableController: tableController),
          ],
        ),
      ),
      onRefresh: () =>
          context.read<UserDataCubit>()
              .reloadUserData(),
    );
  }
}
