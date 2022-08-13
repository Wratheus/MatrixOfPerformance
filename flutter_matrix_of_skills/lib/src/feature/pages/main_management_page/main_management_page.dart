import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/sample_box.dart';
import '../../components/sample_tile.dart';
import '../../responsive/responsive_layout.dart';
import 'cubit/main_management_page_cubit.dart';



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
              print("main page is initialised");
              context.read<MainManagementPageCubit>().loadMainManagementPage();
              return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  )
              );
            }

            if (state is MainManagementPageLoadedState) {
              return (ResponsiveLayout.desktopPlatformSizeCheck()) ?
              RefreshIndicator(
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
                                        return SampleBox();
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
              ) :
              RefreshIndicator(
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
            if (state is MainManagementPageErrorState) {
              return const Scaffold(
                backgroundColor: Colors.blueAccent,
                body: Center(
                  child: Text("Err"),
                ),
              );
            }
            return Container();
          }
      ),
    );
  }
}
