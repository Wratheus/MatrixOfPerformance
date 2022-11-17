import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/page_transition.dart';
import '../../pages/login_page/login_page.dart';

// ignore: must_be_immutable
class DesktopDrawer extends StatefulWidget {
  Widget child;
  final PageController pageController;
  bool isCollapsed = true;
  DesktopDrawer({Key? key, required this.pageController, required this.child}) : super(key: key);

  @override
  State<DesktopDrawer> createState() => _DesktopDrawerState();
}

class _DesktopDrawerState extends State<DesktopDrawer> with TickerProviderStateMixin{
  late final AnimationController animationController;
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth = 80;
    return AnimatedBuilder(
      builder: (context, child){
        return Drawer(
          width: widget.isCollapsed ? (drawerWidth * (animationController.value + 1)) : (drawerWidth * (animationController.value + 2)),
          backgroundColor: MyColors.mainOuterColor,
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.child,
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 21.0, horizontal: 12.0),
                width: double.infinity,
                color: Colors.white.withOpacity(0.04),
                child: buildHeader(),
              ),
              const SizedBox(height: 12),
              buildElement(
                  pageNumber: 0,
                  icon: const Icon(Icons.storage_rounded, color: MyColors.mainBeige, size: 32),
                  onTap: () {
                    setState(() {
                      App.currentPageIndex = 0;
                    });
                    widget.pageController.animateToPage(App.currentPageIndex, duration: const Duration(milliseconds: 350), curve: Curves.ease);
                  },
                  text: const Text('Tables', style: TextStyle(color: MyColors.mainBeige, fontSize: 16, letterSpacing: 4))
              ),
              buildElement(
                pageNumber: 1,
                icon: const Icon(Icons.bar_chart, color: MyColors.mainBeige, size: 32),
                onTap: () {
                  setState(() {
                    App.currentPageIndex = 1;
                  });
                  widget.pageController.animateToPage(App.currentPageIndex, duration: const Duration(milliseconds: 350), curve: Curves.ease);
                },
                text: const Text('Graphs', style: TextStyle(color: MyColors.mainBeige, fontSize: 16, letterSpacing: 4)),
              ),
              const Spacer(),
              buildElement(
                pageNumber: 3,
                icon: const Icon(Icons.logout, color: MyColors.mainBeige, size: 32),
                onTap: () async => {
                  await App.supaBaseController.signOut(context: context),
                  if(App.supaBaseController.client.auth.currentUser == null){
                    Navigator.pushReplacement(context, SlideRightRoute(page: LoginPage()))
                  },
                },
                text: const Text('Sign out', style: TextStyle(color: MyColors.mainBeige, fontSize: 16, letterSpacing: 4)),
              ),
              buildCollapseIcon(animationController: animationController),
            ],
          ),
        );
      },
      animation: animationController,
    );

  }


  Widget buildHeader() {
    return (animationController.value != 1) ?
    const Icon(
      Icons.architecture,
      size: 52,
      color: MyColors.mainBeige,
    ) :
    Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.architecture, size: 52, color: MyColors.mainBeige,),
        Text("Matrix of performance",
            style: TextStyle(color: MyColors.mainBeige, fontSize: 16))
      ],
    );
  }

  Widget buildCollapseIcon({required AnimationController animationController}) {
    const double size = 52;
    final icon = widget.isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    const alignment = Alignment.centerRight;
    final margin = widget.isCollapsed ? null : const EdgeInsets.only(right: 16);
    final width = widget.isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          radius: 0,
          child: SizedBox(
            width: width,
            height: size,
            child: Icon(icon, color: Colors.white),
          ),
          onTap: () {
            setState(() {
              widget.isCollapsed ? {widget.isCollapsed = false, animationController.forward()} : {widget.isCollapsed = true, animationController.reverse()};
            });

          },
        ),
      ),
    );
  }

  Widget buildElement({required double pageNumber, required Widget icon, required Widget text, required VoidCallback onTap}) {
    return Row(
      children: [
        Expanded(
          child: (animationController.value != 1) ?
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              radius: 0,
              onTap: onTap,
              child: Row(
                children: [
                  SampleStyleContainer(
                      color: App.currentPageIndex != pageNumber ? MyColors.mainInnerColor : MyColors.mainBeige.withOpacity(0.2),
                      width: 48, height: 48,
                      child: icon
                  ),
                ],
              ),
            ),
          )
              :
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Row(
                children: [
                  SampleStyleContainer(
                      color: App.currentPageIndex != pageNumber ? MyColors.mainInnerColor : MyColors.mainBeige.withOpacity(0.2),
                      width: 48,
                      height: 48,
                      child: icon),
                  const SizedBox(width: 15),
                  text
                ],
              ),
            )
          ),
        ),
      ],
    );
  }
}