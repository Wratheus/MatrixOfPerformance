import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../components/sample_drop_down_menu.dart';
import '../../../components/sample_style_container.dart';
import '../cubit/main_management_page_cubit.dart';

class MobileGroupManagementTab extends StatelessWidget {
  const MobileGroupManagementTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // first block
        SampleStyleContainer(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select group",
                    style: whiteTextColor
                ),
                Row(
                  children: [
                    SampleDropDownMenu(values: groupValues),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: ()=>{
                          context.read<MainManagementPageCubit>().loadMainManagementPage(tableName: groupValues[0])
                        },
                        child: Text("New", style: whiteTextColor)
                    )
                  ],
                ),
              ]),
        ),
        //second bloc
        SampleStyleContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Add skill", style: whiteTextColor)
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Delete skill", style: whiteTextColor)
              ),
            ],
          ),
        ),
        //third bloc
        SampleStyleContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Add person", style: whiteTextColor)
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Delete person", style: whiteTextColor)
              ),
            ],
          ),
        ),
      ],
    );
  }
}
