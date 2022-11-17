// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_stateful_button/template.dart';

import '../../../core/classes/app.dart';
import '../../../core/services/page_transition.dart';
import '../../components/sample_elevated_button.dart';
import '../../components/sample_stateful_button/stateful_button.dart';
import '../../components/sample_stateful_button/stateful_button_controller.dart';
import '../../components/sample_text_field.dart';
import '../../responsive/desktop_body.dart';
import '../login_page/login_page.dart';

class PasswordResetPage extends StatelessWidget {
  final TextEditingController _textControllerLogin = TextEditingController();

  PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonController buttonController = ButtonController();
    App.deepLinkController.init(buildContext: context); // listener init
    return Scaffold(
        backgroundColor: MyColors.mainOuterColor,
        body: Platform.isWindows ?  WindowBorder(
            color: MyColors.mainCanvas,
            width: 1,
            child: Stack(
                children: [
                  RightSide(
                      child: Container()
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      appIcon,
                      const SizedBox(height: 5,),
                      Center(child: Text('Enter e-mail address\n to reset your password', style: whiteTextColor, textAlign: TextAlign.center)),
                      const SizedBox(height: 10),
                      SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 100,
                        child: StatefulButton(
                          height: 40,
                          borderRadius: BorderRadius.circular(16.0),
                          color: MyColors.mainInnerColor,
                          border: Border.all(width: 2, color: MyColors.mainBeige.withOpacity(0.4)),
                          onTap: () async {
                             buttonController.state = ButtonState.loading;
                             await App.supaBaseController.passwordReset(email: _textControllerLogin.text,  context: context);
                             buttonController.state = ButtonState.enable;
                            },
                          controller: buttonController,
                          child: const TemplateButton1(
                            title: 'R E S E T',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: InkWell(
                          radius: 0,
                          onTap: () async => {
                            Navigator.pushReplacement(context, SlideRightRoute(page: LoginPage())),
                          },
                          child: Text("Back",
                            style: greyTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
            )
        )
            :
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appIcon,
                const SizedBox(height: 5,),
                Center(child: Text('Enter e-mail address\n to reset your password', style: whiteTextColor, textAlign: TextAlign.center)),
                const SizedBox(height: 15,),
                SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, borderColor: MyColors.mainBeige, textColor: whiteTextColor, width: 250),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: SampleElevatedButton(
                    onPressed: () async => await App.supaBaseController.passwordReset(email: _textControllerLogin.text,  context: context),
                    child: Text('RESET', style: whiteTextColor),
                  ),
                ),
                SampleElevatedButton(
                    onPressed: () async => {
                      Navigator.pushReplacement(context, SlideRightRoute(page: LoginPage())),
                    },
                    child: Text('Back', style: whiteTextColor)
                ),
                const SizedBox(height: 10,),
              ],
            )
        )
    );
  }
}