import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/cubit/main_management_page_cubit.dart';

import '../../../responsive/responsive_layout.dart';


class GroupTableView extends StatelessWidget {
  const GroupTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.mainOuterColor
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: (state as MainManagementPageLoadedState).tableData.length+1,
            itemBuilder: (context, row) {
            if(row == 0) {
              return Container(
                width: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    border: Border.all(color: MyColors.mainCanvas),
                    color: MyColors.mainInnerColor
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (state).tableData[row].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (ResponsiveLayout.desktopPlatformSizeCheck()) ? 2 : 1,
                    crossAxisCount: (state).tableData[row].length
                  ),
                  itemBuilder: (context, column) {
                    return Center(child: Text((state).tableData[row].keys.elementAt(column).toString(), style: whiteTextColor));
                    }));
                }
                row--;
                return Container(
                  width: 5,
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.mainCanvas),
                      color: MyColors.mainOuterColor
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (state).tableData[row].length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (ResponsiveLayout.desktopPlatformSizeCheck()) ? 2 : 1,
                      crossAxisCount: (state).tableData[row].length
                    ),
                    itemBuilder: (context, column) {
                      return Center(child: Text((state).tableData[row].values.elementAt(column).toString(), style: whiteTextColor));
                    }),
                );
              }
          ),
        );
      },
    );
  }
}
