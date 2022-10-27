import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/dialogs/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_loading_page.dart';

import '../../cubit/user_data/user_data_cubit.dart';
import '../../responsive/desktop_body.dart';
import '../../responsive/mobile_body.dart';
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
              context.read<UserDataCubit>().loadUserData();
              return const SampleLoadingPage();
            }
            if (state is UserDataLoadedState) {
              if (kDebugMode) {
                print('Table management page is loaded');
              }
              return TableManagementPageLayout();
            }
            if (state is UserDataErrorState) {
              return SampleErrorDialog(errorMessage: "Main management page\nCubit error state", route: const ResponsiveLayout(
                  desktopBody: DesktopScaffold(),
                  mobileBody: MobileScaffold()));
            }
            return Container();
          }
      ),
    );
  }
}
