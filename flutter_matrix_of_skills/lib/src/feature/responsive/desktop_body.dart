import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../components/drawer/desktop_drawer.dart';
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
      appBar: SampleAppbar(title: 'M a t r i x   o f   P e r f o r m a n c e', backgroundColor: MyColors.mainInnerColor, textColor: whiteTextColor),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // open drawer
          DesktopDrawer(pageController: pageController),
          // routing implementation
          Expanded(
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
