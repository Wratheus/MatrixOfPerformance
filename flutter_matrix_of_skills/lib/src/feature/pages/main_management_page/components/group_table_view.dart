import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_border_container_cell.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/cubit/main_management_page_cubit.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/responsive_layout.dart';

class GroupTableView extends StatelessWidget {
  const GroupTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(
      builder: (context, state) {
        if ((state as MainManagementPageLoadedState).tableData.isEmpty == false) {
          return (ResponsiveLayout.desktopPlatformSizeCheck()) ?
          // Desktop layout
          SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: SampleStyleContainer(
              width: 900,
              child: ListView.builder(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (state).tableData.length,
                  itemBuilder: (context, row) {
                    if(row == 0) {
                      return SampleBorderContainerCell(
                          color: MyColors.mainInnerColor,
                          child: GridView.builder(
                              controller: ScrollController(),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (state).tableData[row].length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2,
                                  crossAxisCount: (state).tableData[row].length
                              ),
                              itemBuilder: (context, column) {
                                return Center(child: Text((state).tableData[row].keys.elementAt(column).toString(), style: whiteTextColor));
                              }));
                    }
                    // row--; hide first row
                    return SampleBorderContainerCell(
                      color: MyColors.mainOuterColor,
                      child: GridView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (state).tableData[row].length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2,
                              crossAxisCount: (state).tableData[row].length
                          ),
                          itemBuilder: (context, column) {
                            return Center(child: Text((state).tableData[row].values.elementAt(column).toString(), style: whiteTextColor));
                          }),
                    );
                  }
              ),
            ),
          ) :
          // Phone Layout
          SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: SampleStyleContainer(
              width: 800,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount: (state).tableData.length,
                  itemBuilder: (context, row) {
                    if(row == 0) {
                      return SampleBorderContainerCell(
                          color: MyColors.mainInnerColor,
                          child: GridView.builder(
                              controller: ScrollController(),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (state).tableData[row].length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (state).tableData[row].length
                              ),
                              itemBuilder: (context, column) {
                                return Center(child: Text((state).tableData[row].keys.elementAt(column).toString(), style: whiteTextColor));
                              }));
                    }
                    // row--; hide first row
                    return SampleBorderContainerCell(
                      color: MyColors.mainOuterColor,
                      child: GridView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (state).tableData[row].length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2,
                              crossAxisCount: (state).tableData[row].length
                          ),
                          itemBuilder: (context, column) {
                            return Center(child: Text((state).tableData[row].values.elementAt(column).toString(), style: whiteTextColor));
                          }),
                    );
                  }
              ),
            ),
          );
        }
        else {
          return Container();
        }
      },
    );
  }
}
