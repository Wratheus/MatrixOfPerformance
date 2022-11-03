// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

import '../../../core/classes/app.dart';
import '../../components/sample_elevated_button.dart';
import '../../components/sample_text_field.dart';
import '../../responsive/desktop_body.dart';
import '../login_page/login_page.dart';

class PasswordResetPage extends StatelessWidget {
  final TextEditingController _textControllerLogin = TextEditingController();

  PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.deepLinkController.init(buildContext: context); // listener init
    return Scaffold(
        backgroundColor: MyColors.mainCanvas,
        body: Platform.isWindows ?  WindowBorder(
            color: MyColors.mainCanvas,
            width: 1,
            child: Row(
                children: [
                  RightSide(
                    child:SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Center(
                        child: Column(
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
                              width: 160,
                              child: SampleElevatedButton(
                                onPressed: () async => await App.supaBaseController.passwordReset(email: _textControllerLogin.text,  context: context),
                                child: Text('RESET', style: whiteTextColor),
                              ),
                            ),
                            SampleElevatedButton(
                                onPressed: () async => {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                                },
                                child: Text('Back', style: whiteTextColor)
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  )
                ]
            )
        )
            : Center(
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
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