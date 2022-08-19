import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_management_tab.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_selection_tab.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/components/group_table_view.dart';

import '../cubit/main_management_page_cubit.dart';

class MainManagementPageDesktopLayout extends StatelessWidget {
  const MainManagementPageDesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    GroupSelectionTab(),
                    GroupManagementTab(),
                    GroupTableView()
                  ]
                ),
              )
            ]
          )
        ),
      ),
      onRefresh: () =>
          context.read<MainManagementPageCubit>()
              .reloadMainManagementPage(),
    );
  }
}
