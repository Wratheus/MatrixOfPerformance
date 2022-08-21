import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

import '../components/desktop_group_management_tab.dart';
import '../components/desktop_group_table_view.dart';
import '../cubit/main_management_page_cubit.dart';

class MainManagementPageDesktopLayout extends StatelessWidget {
  const MainManagementPageDesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 5),
            DesktopGroupManagementTab(),
            DesktopGroupTableView(),
          ]
        ),
      ),
      onRefresh: () =>
          context.read<MainManagementPageCubit>()
              .reloadMainManagementPage(),
    );
  }
}
