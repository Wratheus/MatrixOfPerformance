part of 'constants.dart';

class MyColors {

  static const Color customBrightGreen = Color(0xff0eff7e);
  static const Color customGrey = Color(0xffeff4f2);
  static const Color customBluePurple = Color(0xff5b60ec);
  static const Color customBlack = Color(0xff11111d);
  static const Color customDeepPurple = Color(0xff1d1b31);

  static const Color mainBeige = Color(0xfff3f6ff);
  static const Color mainHighlightedBlue = Color(0xff45546a);
  static const Color mainCanvas = Color(0xff171a20);
  static const Color mainOuterColor = Color(0xff272931);
  static const Color mainInnerColor = Color(0xff2f323a);

}

final buttonColors = WindowButtonColors(
    iconNormal: MyColors.mainBeige,
    mouseOver: MyColors.mainInnerColor,
    mouseDown: MyColors.mainBeige.withOpacity(0.4),
    iconMouseOver: MyColors.mainBeige,
    iconMouseDown: MyColors.mainBeige);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: MyColors.mainBeige,
    iconMouseOver: MyColors.mainBeige);
