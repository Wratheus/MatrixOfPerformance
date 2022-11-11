import 'package:flutter/material.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/app_ui_disable_glow_effect.dart';
import '../../../core/services/page_transition.dart';
import '../../pages/login_page/login_page.dart';

class MobileDrawer extends StatelessWidget {
  final PageController pageController;
  const MobileDrawer({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.mainOuterColor,
      elevation: 0,
      child: DisableGlowEffect(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.architecture,
                size: 128,
                color: MyColors.mainBeige,
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                  leading: const Icon(Icons.storage_rounded, color: MyColors.mainBeige),
                  title: Text(
                    'Tables manager',
                    style: whiteTextColor,
                  ),
                  onTap: () => {
                    pageController.animateToPage(0, duration: const Duration(milliseconds: 350), curve: Curves.ease),
                  }
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                  leading: const Icon(Icons.bar_chart, color: MyColors.mainBeige),
                  title: Text(
                    'Graphs',
                    style: whiteTextColor,
                  ),
                  onTap: () => {
                    pageController.animateToPage(1, duration: const Duration(milliseconds: 350), curve: Curves.ease),
                  }
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                  leading: const Icon(Icons.logout, color: MyColors.mainBeige),
                  title: Text(
                    'Sign out',
                    style: whiteTextColor,
                  ),
                  onTap: () async => {
                    await App.supaBaseController.signOut(context: context),
                    if(App.supaBaseController.client.auth.currentUser == null){
                      Navigator.pushReplacement(context, SlideRightRoute(page: LoginPage()))
                    },
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}