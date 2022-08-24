import 'package:flutter/material.dart';

import '../../core/classes/app.dart';
import '../../core/constants/constants.dart';
import '../pages/login_page/login_page.dart';

// ignore: must_be_immutable
class NavigationDrawer extends StatefulWidget {
  PageController pageController;
  NavigationDrawer({Key? key, required this.pageController}) :
        super(key: key);
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.mainOuterColor,
      elevation: 0,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.favorite,
              size: 64,
              color: MyColors.mainBeige,
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.bar_chart, color: MyColors.mainBeige),
              title: Text(
                'TABLES PAGE',
                style: whiteTextColor,
              ),
              onTap: () => {
                widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 350), curve: Curves.ease),
              }
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.settings, color: MyColors.mainBeige),
              title: Text(
                'TEST NAV 2',
                style: whiteTextColor,
              ),
                onTap: () => widget.pageController.animateToPage(1, duration: const Duration(milliseconds: 350), curve: Curves.ease)
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.info, color: MyColors.mainBeige),
              title: Text(
                'TEST NAV 3',
                style: whiteTextColor,
              ),
                onTap: () => widget.pageController.animateToPage(2, duration: const Duration(milliseconds: 350), curve: Curves.ease)
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
                await App.supaBaseController?.signOut(context: context),
                  if(App.supaBaseController?.client.auth.currentUser == null){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()))
                  },
              }
            ),
          ),
        ],
      ),
    );
  }
}