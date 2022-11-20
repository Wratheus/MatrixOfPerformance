import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/dialogs/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_loading_page.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/layout/empty_tables_dialog.dart';

import '../../../core/classes/app.dart';
import '../../cubit/user_data/user_data_cubit.dart';
import '../../responsive/responsive_layout.dart';

import 'layout/layout.dart';

class TableManagementPage extends StatelessWidget {
  const TableManagementPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit(),
      child: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is UserDataInitialState) {
              context.read<UserDataCubit>().informInitial();
              context.read<UserDataCubit>().loadUserData(context: context);
              return const SampleLoadingPage();
            }
            if (state is UserDataLoadedState) {
              if(state.allUserTables.isNotEmpty) {
                return TableManagementPageLayout();
              }else{
                return const EmptyTablesDialog();
              }
            }
            if (state is UserDataErrorState) { {
                App.currentPageIndex = 0;
                return SampleErrorDialog(
                    errorMessage: "Main management page\nCubit error state",
                    route: const ResponsiveLayout());
              }
            }
            return Container();
          }
      ),
    );
  }
}
