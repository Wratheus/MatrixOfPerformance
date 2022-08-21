import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_border_container_cell.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:flutter_matrix_of_skills/src/feature/pages/main_management_page/cubit/main_management_page_cubit.dart';


class DesktopGroupTableView extends StatelessWidget {
  const DesktopGroupTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainManagementPageCubit, MainManagementPageState>(
      builder: (context, state) {
        return SampleStyleContainer(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: (state as MainManagementPageLoadedState).tableData.length+1,
            itemBuilder: (context, row) {
            if(row == 0) {
              return SampleBorderContainerCell(
                  color: MyColors.mainInnerColor,
                  child: GridView.builder(
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
                row--;
                return SampleBorderContainerCell(
                  color: MyColors.mainOuterColor,
                  child: GridView.builder(
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
        );
      },
    );
  }
}
