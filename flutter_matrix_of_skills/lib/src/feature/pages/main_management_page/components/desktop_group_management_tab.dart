import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';

import '../../../../core/constants/constants.dart';
import '../../../components/sample_drop_down_menu.dart';
import '../cubit/main_management_page_cubit.dart';

class DesktopGroupManagementTab extends StatelessWidget {
  const DesktopGroupManagementTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SampleStyleContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
            ],
          ),
        ),
        SampleStyleContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Add skill", style: whiteTextColor)
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Delete skill", style: whiteTextColor)
              ),
            ],
          ),
        ),
        SampleStyleContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Add person", style: whiteTextColor)
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Delete person", style: whiteTextColor)
              ),
            ],
          ),
        )
      ],
    );
  }
}
