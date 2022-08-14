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
                'TABLES PAGE',
                style: drawerTextColor,
              ),
              onTap: () => {
                widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 350), curve: Curves.ease),
              }
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'TEST NAV 2',
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
                'TEST NAV 3',
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
                'Sign out',
                style: drawerTextColor,
              ),
                onTap: () async => {
                await App.supaBaseController?.signOut(),
                  if(App.supaBaseController?.client.auth.currentUser == null){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                  },
              }
            ),
          ),
        ],
      ),
    );
  }
}