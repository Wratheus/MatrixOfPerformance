import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class GroupManagementTab extends StatelessWidget {
  const GroupManagementTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyColors.mainOuterColor,
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: MyColors.mainInnerColor
            ),
            child: ElevatedButton(
                onPressed: ()=>{},
                child: Text("Add skill", style: whiteTextColor)
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: const BoxDecoration(
              color: MyColors.mainInnerColor
            ),
            child: ElevatedButton(
                onPressed: ()=>{},
                child: Text("Add person", style: whiteTextColor)
            ),
          ),
        ],
      ),
    );
  }
}
