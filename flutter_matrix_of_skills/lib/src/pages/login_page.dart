// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/utils/sample_button_style.dart';
import 'package:flutter_matrix_of_skills/src/utils/sample_text_field.dart';

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
      appBar: myAppBar,
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
              SampleTextField(textController: _textControllerLogin, labelText: 'Username', hideText: false),
              const SizedBox(height: 30,),
              SampleTextField(textController: _textControllerPassword, labelText: 'Password', hideText: true),
              const SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: () => print('${_textControllerLogin.text}, ${_textControllerPassword.text}'),
                  child: SampleElevatedButtonStyleContainer(labelText: 'Login')
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*              TextField(
              controller: _textControllerLogin,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
              style: drawerTextColor,
              keyboardType: TextInputType.text,
              onChanged: (_) => {
                setState(() {
                  login = _textControllerLogin.text;
                })}
              ),*/
/*TextField(
                  controller: _textControllerLogin,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                  style: drawerTextColor,
                  keyboardType: TextInputType.text,
                  onChanged: (_) => {
                    setState(() {
                      password = _textControllerPassword.text;
                    })}
              ),*/