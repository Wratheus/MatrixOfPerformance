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
        color: Colors.grey[400],
      ),
      child: Row(
        children: <Widget>[
          ElevatedButton(
              onPressed: ()=>{},
              child: Text("Add skill", style: buttonTextColor)
          ),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: ()=>{},
              child: Text("Add person", style: buttonTextColor)
          ),
        ],
      ),
    );
  }
}
