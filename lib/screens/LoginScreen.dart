import 'package:dbkliknew/widgets/CustomComponents/CustomBottom.dart';
import 'package:dbkliknew/widgets/LoginWidget.dart';
import 'package:dbkliknew/widgets/CustomComponents/TextInputField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoginWidget(),
        ),
      ),
    );
  }
}
