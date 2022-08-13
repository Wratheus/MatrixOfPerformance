// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';

import '../../../core/classes/app.dart';
import '../../../core/database/supabase_controller.dart';
import '../../components/sample_appbar.dart';
import '../../components/sample_button_style.dart';
import '../../components/sample_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController _textControllerLogin = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SampleAppbar(title: 'Welcome'),
      backgroundColor: defaultBackgroundColor,
      body: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(child: Text('Welcome\nplease login to continue', style: buttonTextColor, textAlign: TextAlign.center)),
              const SizedBox(height: 15,),
              SampleTextField(textController: _textControllerLogin, labelText: 'E-mail', hideText: false, hintText: 'example@email.com'),
              const SizedBox(height: 20,),
              SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true, hintText: 'you\'re password'),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () =>
                      // print('${_textControllerLogin.text}, ${_textControllerPassword.text}'),
                  App.supaBaseController?.signIn(_textControllerLogin.text, _textControllerPassword.text),
                  child: SampleElevatedButtonStyleContainer(labelText: 'Login')
              ),
              const SizedBox(height: 10,),
              Center(
                child: InkWell(
                  onTap: () {Navigator.pushNamed(context, "myRoute");},
                  child: Text("Register",
                    style: buttonTextColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}