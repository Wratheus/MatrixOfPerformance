import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../utils/sample_box.dart';
import '../../utils/sample_tile.dart';
import '../../utils/main_drawer.dart';
import '../main_management_page.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  PageController pageController = PageController(); //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      drawer: NavigationDrawer(pageController: pageController),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
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
