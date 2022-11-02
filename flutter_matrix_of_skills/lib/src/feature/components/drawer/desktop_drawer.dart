import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../pages/login_page/login_page.dart';

// ignore: must_be_immutable
class DesktopDrawer extends StatefulWidget {
  final PageController pageController;
  bool isCollapsed = true;
  double pageControllerPage = 0;
  DesktopDrawer({Key? key, required this.pageController}) : super(key: key);

  @override
  State<DesktopDrawer> createState() => _DesktopDrawerState();
}

class _DesktopDrawerState extends State<DesktopDrawer>{
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {

    final double drawerWidth = widget.isCollapsed ? 80 : 250;
    final EdgeInsetsGeometry safeArea = EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    return Drawer(
      width: drawerWidth,
      backgroundColor: MyColors.mainOuterColor,
      elevation: 4,
      child: Column(
        children: [
          Container(
            padding: safeArea,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24).add(safeArea),
                  color: Colors.white.withOpacity(0.04),
                  child: buildHeader(),
              )
          ),
          const SizedBox(height: 12),
          buildElement(
              pageNumber: 0,
              icon: const Icon(Icons.storage_rounded, color: MyColors.mainBeige, size: 38),
              onTap: () {
                setState(() {
                  widget.pageControllerPage = 0;
                });
                widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 350), curve: Curves.ease);
              },
              text: const Text('T a b l e s', style: TextStyle(color: MyColors.mainBeige, fontSize: 16))
          ),
          buildElement(
              pageNumber: 1,
              icon: const Icon(Icons.bar_chart, color: MyColors.mainBeige, size: 38),
              onTap: () {
                setState(() {
                  widget.pageControllerPage = 1;
                });
                widget.pageController.animateToPage(1, duration: const Duration(milliseconds: 350), curve: Curves.ease);
              },
              text: const Text('G r a p h s', style: TextStyle(color: MyColors.mainBeige, fontSize: 16)),
          ),
          const Spacer(),
          buildElement(
            pageNumber: 3,
            icon: const Icon(Icons.logout, color: MyColors.mainBeige, size: 38),
            onTap: () async => {
              await App.supaBaseController.signOut(context: context),
              if(App.supaBaseController.client.auth.currentUser == null){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()))
              },
            },
            text: const Text('S i g n    o u t', style: TextStyle(color: MyColors.mainBeige, fontSize: 16)),
          ),
          buildCollapseIcon(),
        ],
      ),
    );
  }


  Widget buildHeader() => widget.isCollapsed ?
  const Icon(
    Icons.architecture,
    size: 42,
    color: MyColors.mainBeige,
  ) :
  Row(
    children: const [
      Icon(Icons.architecture, size: 64, color: MyColors.mainBeige,),
      Text("Matrix of performance", style: TextStyle(color: MyColors.mainBeige, fontSize: 16))
    ],
  );

  Widget buildCollapseIcon() {
    const double size = 52;
    final icon = widget.isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = widget.isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = widget.isCollapsed ? null : const EdgeInsets.only(right: 16);
    final width = widget.isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: SizedBox(
            width: width,
            height: size,
            child: Icon(icon, color: Colors.white),
          ),
          onTap: () {
            setState(() {
              widget.isCollapsed ? widget.isCollapsed = false : widget.isCollapsed = true;
            });
          },
        ),
      ),
    );
  }

  Widget buildElement({required double pageNumber, required Widget icon, required Widget text, required VoidCallback onTap}) {
    return widget.isCollapsed
        ?
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onTap,
        child: SampleStyleContainer(
            color: widget.pageControllerPage != pageNumber ? MyColors.mainInnerColor : MyColors.mainHighlightedBlue,
            width: 54, height: 54,
            child: icon
        ),
      ),
    )
        :
    InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SampleStyleContainer(
                color: widget.pageControllerPage != pageNumber ? MyColors.mainInnerColor : MyColors.mainHighlightedBlue,
                width: 54,
                height: 54,
                child: icon),
            const SizedBox(width: 20),
            text
          ],
        ),
      )
    );
  }
}