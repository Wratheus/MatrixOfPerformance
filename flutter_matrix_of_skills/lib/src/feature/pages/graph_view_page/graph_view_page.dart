import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/dialogs/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_loading_page.dart';

import '../../../core/classes/app.dart';
import '../../cubit/user_data/user_data_cubit.dart';
import '../../responsive/responsive_layout.dart';
import 'layout/layout.dart';

// ignore: must_be_immutable
class GraphViewPage extends StatelessWidget {
  const GraphViewPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit(),
      child: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is UserDataInitialState) {
              context.read<UserDataCubit>().informInitial();
              context.read<UserDataCubit>().loadUserData();
              return const SampleLoadingPage();
            }
            if (state is UserDataLoadedState) {
              if(state.tableData.isNotEmpty && state.tableData.length >= 3 && (state.tableData[0]).keys.toList().length >= 5) {
                return GraphViewPageLayout();
              }else{
                App.currentPageIndex = 0;
                return SampleErrorDialog(errorMessage: "Maybe you have no tables, or your tables are empty\nTable should have at least 3 rows with 3 skills.", route: const ResponsiveLayout());
              }
            }
            if (state is UserDataErrorState) {
              App.currentPageIndex = 0;
              return SampleErrorDialog(errorMessage: "Graph view page\nCubit error state.", route: const ResponsiveLayout());
            }
            return Container();
          }
      ),
    );
  }
}
