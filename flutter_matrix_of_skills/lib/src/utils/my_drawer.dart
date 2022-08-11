import 'package:flutter/material.dart';
import '../pages/main_management_page.dart';

import '../constants/constants.dart';
import '../pages/responsive/desktop_body.dart';
import '../pages/responsive/mobile_body.dart';
import '../pages/responsive/responsive_layout.dart';

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
      backgroundColor: Colors.grey[350],
      elevation: 0,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.favorite,
              size: 64,
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'T A B L E S   P A G E',
                style: drawerTextColor,
              ),
              onTap: () => widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 350), curve: Curves.ease)
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'T E S T   N A V   2',
                style: drawerTextColor,
              ),
                onTap: () => widget.pageController.animateToPage(1, duration: const Duration(milliseconds: 350), curve: Curves.ease)
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.info),
              title: Text(
                'T E S T   N A V   3',
                style: drawerTextColor,
              ),
                onTap: () => widget.pageController.animateToPage(2, duration: const Duration(milliseconds: 350), curve: Curves.ease)
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'T E S T   N A V   4',
                style: drawerTextColor,
              ),
                onTap: () => widget.pageController.animateToPage(3, duration: const Duration(milliseconds: 350), curve: Curves.ease)
            ),
          ),
        ],
      ),
    );
  }
}