import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

import '../components/mobile_group_management_tab.dart';
import '../components/mobile_group_table_view.dart';
import '../cubit/main_management_page_cubit.dart';

class MainManagementPagePhoneLayout extends StatelessWidget {
  const MainManagementPagePhoneLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MobileGroupManagementTab(),
            MobileGroupTableView()
          ]
        ),
      ),
      onRefresh: () =>
          context.read<MainManagementPageCubit>()
              .reloadMainManagementPage(),
    );
  }
}
