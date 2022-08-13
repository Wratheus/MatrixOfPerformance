import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/sample_box.dart';
import '../../../components/sample_tile.dart';
import '../cubit/main_management_page_cubit.dart';

class MainManagementPagePhoneLayout extends StatelessWidget {
  const MainManagementPagePhoneLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return SampleBox();
                      },
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const SampleTile();
                  },
                ),
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
