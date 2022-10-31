import 'package:flutter/material.dart';

import '../../../core/classes/app.dart';
import '../../../core/constants/constants.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_text_field.dart';

// ignore: must_be_immutable
class NewPasswordPage extends StatelessWidget {
  String refreshToken;
  NewPasswordPage({Key? key, required this.refreshToken}) : super(key: key);
  final TextEditingController _textControllerPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SampleAppbar(title: 'Welcome',
          backgroundColor: MyColors.mainOuterColor,
          textColor: whiteTextColor),
      backgroundColor: MyColors.mainCanvas,
      body: Center(
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
            ElevatedButton(
              onPressed: () async =>
              await App.supaBaseController?.newPasswordCommit(
                newPassword: _textControllerPass.text, context: context
              ),
              child: Text('Commit', style: whiteTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

