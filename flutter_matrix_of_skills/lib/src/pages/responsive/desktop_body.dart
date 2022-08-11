import 'package:flutter/material.dart';

import 'package:flutter_matrix_of_skills/src/pages/main_management_page.dart';
import '../../constants/constants.dart';
import '../../utils/my_drawer.dart';

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
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            Expanded(
              flex: 2,
                child: NavigationDrawer(pageController: pageController)
            ),
            // routing implementation
            Expanded(
              flex: 6,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (_) => (index) { print('page changed to ${pageList[index]}'); },
                  children: pageList // print what page is now selected
                ),
            ),
          ],
        ),
      ),
    );
  }
}
