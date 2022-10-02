import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../components/main_drawer.dart';
import '../components/sample_appbar.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  PageController pageController = PageController(); // Navigation element
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainCanvas,
      appBar: SampleAppbar(title: 'Matrix of Performance', backgroundColor: MyColors.mainInnerColor, textColor: whiteTextColor),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // open drawer
          Expanded(
            flex: 2,
              child: NavigationDrawer(pageController: pageController)
          ),
          // routing implementation
          Expanded(
            flex: 8,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: pageList
              ),
          ),
        ],
      ),
    );
  }
}
