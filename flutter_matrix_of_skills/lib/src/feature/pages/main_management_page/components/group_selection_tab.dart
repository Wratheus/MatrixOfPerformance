import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../components/sample_drop_down_menu.dart';
import '../cubit/main_management_page_cubit.dart';

class GroupSelectionTab extends StatelessWidget {
  const GroupSelectionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[400],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select group",
              style: highlightedTextColor
          ),
          Row(
            children: [
              SampleDropDownMenu(values: groupValues),
              ElevatedButton(
                  onPressed: ()=>{
                    context.read<MainManagementPageCubit>().loadMainManagementPage(tableName: groupValues[0])
                  },
                  child: Text("New", style: buttonTextColor)
              )
            ],
          ),
        ],
      ),
    );
  }
}
