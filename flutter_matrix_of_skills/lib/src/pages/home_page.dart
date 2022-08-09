import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../pages/main_management_page.dart';

// Home page is navigation bar(Main page selected by default)
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int? _pageIndex;
  HomePage({Key? key, int? pageIndex}) :
        _pageIndex = pageIndex,
        super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState(_pageIndex);
}

class _HomePageState extends State<HomePage> {
  int? _pageIndex;
  _HomePageState(pageIndex) :
        _pageIndex = pageIndex;
  GlobalKey bottomNavigationKey = GlobalKey();
  List<Widget> pageList = <Widget>[
    const MainManagementPage()
  ];
  @override
  Widget build(BuildContext context) {
    _pageIndex ??= 0;// if index is null default is MainManagementPage
    return Scaffold(
        backgroundColor: Colors.brown,
        body: pageList.elementAt(_pageIndex!),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Colors.brown.withOpacity(0.65), Colors.blueAccent.withOpacity(0.65)])),
          child: CurvedNavigationBar(
              height: 50,
              key: bottomNavigationKey,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Colors.brown.shade600,
              color: Colors.transparent,
              animationDuration: const Duration(milliseconds: 450),
              animationCurve: Curves.linear,
              onTap: (value){
                setState(() {
                  _pageIndex = value;});},
              index: _pageIndex!,
              items: const [
                Icon(Icons.person, size: 35, color: Colors.white),
              ]
          ),
        )
    );
  }
}