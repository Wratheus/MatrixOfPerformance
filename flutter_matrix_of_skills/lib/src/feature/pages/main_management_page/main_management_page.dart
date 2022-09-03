import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_error_dialog.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_loading_page.dart';

import '../../responsive/desktop_body.dart';
import '../../responsive/mobile_body.dart';
import '../../responsive/responsive_layout.dart';
import 'cubit/main_management_page_cubit.dart';
import 'layout/layout.dart';

// ignore: must_be_immutable
class MainManagementPage extends StatelessWidget {
  const MainManagementPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainManagementPageCubit(),
      child: BlocBuilder<MainManagementPageCubit, MainManagementPageState>(
          builder: (context, state) {
            if (state is MainManagementPageInitialState) {
              context.read<MainManagementPageCubit>().informInitial();
              context.read<MainManagementPageCubit>().loadMainManagementPage();
              return const SampleLoadingPage();
            }
            if (state is MainManagementPageLoadedState) {
              return const MainManagementPageLayout();
            }
            if (state is MainManagementPageErrorState) {
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
