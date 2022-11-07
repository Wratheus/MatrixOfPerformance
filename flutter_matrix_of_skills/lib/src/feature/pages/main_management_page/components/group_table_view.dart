import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_border_container_cell.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/responsive/responsive_layout.dart';

import '../../../cubit/user_data/user_data_cubit.dart';

class GroupTableView extends StatelessWidget {
  const GroupTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if ((state as UserDataLoadedState).tableData.isEmpty == false) {
          return (ResponsiveLayout.desktopPlatformSizeCheck()) ?
          // Desktop layout
          SampleStyleContainer(
            width: MediaQuery.of(context).size.width * 1,
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
                                childAspectRatio: (state).tableData[0].keys.toList().length >= 6 ? 1.5 : 5,
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
                            childAspectRatio:  (state).tableData[0].keys.toList().length >= 6 ? 1.5 : 6,
                            crossAxisCount: (state).tableData[row].length
                        ),
                        itemBuilder: (context, column) {
                          return Center(child: Text((state).tableData[row].values.elementAt(column).toString(), style: whiteTextColor));
                        }),
                  );
                }
            ),
          ) :
          // Mobile Layout
          SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: (state.tableData[0]).length < 6  // if there is more than 6 columns increase width
                  ?
              MediaQuery.of(context).size.width * 0.97
                  :
              (100 * (state.tableData[0].length)).toDouble(),
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
                              childAspectRatio: 1.5,
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
