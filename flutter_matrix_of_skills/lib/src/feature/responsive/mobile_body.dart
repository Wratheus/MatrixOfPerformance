import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../components/drawer/mobile_drawer.dart';
import '../components/sample_appbar.dart';

// ignore: must_be_immutable
class MobileScaffold extends StatelessWidget {
  MobileScaffold({Key? key}) : super(key: key);

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainCanvas,
      appBar: SampleAppbar(title: 'Matrix of Performance', backgroundColor: MyColors.mainOuterColor, textColor: whiteTextColor),
      drawer: MobileDrawer(pageController: pageController),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (_) => (index) {},
                  children: pageList
              ),
            ),
          ],
        ),
      ),
    );
  }
}
