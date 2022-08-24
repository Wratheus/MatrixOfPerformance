import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

import '../components/group_management_tab.dart';
import '../components/group_table_view.dart';
import '../cubit/main_management_page_cubit.dart';

class MainManagementPageLayout extends StatelessWidget {
  const MainManagementPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 5),
              GroupManagementTab(),
              GroupTableView(),
            ]
          ),
        ),
      ),
      onRefresh: () =>
          context.read<MainManagementPageCubit>()
              .reloadMainManagementPage(),
    );
  }
}
