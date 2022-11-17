import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_elevated_button.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../components/sample_text_field.dart';
import '../../responsive/desktop_body.dart';

// ignore: must_be_immutable
class NewPasswordPage extends StatelessWidget {
  String refreshToken;
  NewPasswordPage({Key? key, required this.refreshToken}) : super(key: key);
  final TextEditingController _textControllerPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      Center(child: Text('Enter your new password', style: whiteTextColor,
                          textAlign: TextAlign.center)),
                      const SizedBox(height: 15,),
                      SampleTextField(textController: _textControllerPass,
                          labelText: 'New password',
                          hideText: false,
                          borderColor: MyColors.mainBeige,
                          textColor: whiteTextColor,
                          width: 250),
                      const SizedBox(height: 15,),
                      SampleElevatedButton(
                        onPressed: () async =>
                        await App.supaBaseController.newPasswordCommit(
                            newPassword: _textControllerPass.text, context: context
                        ),
                        child: Text('Commit', style: whiteTextColor),
                      ),
                    ],
                  ),

                ]
            )
        ): Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appIcon,
              const SizedBox(height: 5,),
              Center(child: Text('Enter your new password', style: whiteTextColor,
                  textAlign: TextAlign.center)),
              const SizedBox(height: 15,),
              SampleTextField(textController: _textControllerPass,
                  labelText: 'New password',
                  hideText: false,
                  borderColor: MyColors.mainBeige,
                  textColor: whiteTextColor,
                  width: 250),
              const SizedBox(height: 15,),
              SampleElevatedButton(
                onPressed: () async =>
                await App.supaBaseController.newPasswordCommit(
                    newPassword: _textControllerPass.text, context: context
                ),
                child: Text('Commit', style: whiteTextColor),
              ),
            ],
          ),
        )
    );
  }
}

