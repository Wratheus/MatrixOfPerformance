import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/main_management_page/cubit/main_management_page_cubit.dart';
import '../sample_box.dart';
import '../sample_tile.dart';

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
                  flex: 6,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 4,
                        child: SizedBox(
                          width: double.infinity,
                          child: GridView.builder(
                            itemCount: 4,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              return const SampleBox();
                            },
                          ),
                        ),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const SampleTile();
                        },
                      ),
                    ],
                  ),
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
