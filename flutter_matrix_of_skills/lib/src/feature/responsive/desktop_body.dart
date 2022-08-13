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
      backgroundColor: defaultBackgroundColor,
      appBar: SampleAppbar(title: 'Matrix of Performance'),
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
