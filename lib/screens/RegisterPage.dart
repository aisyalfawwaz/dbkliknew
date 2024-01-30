import 'package:flutter/material.dart';
import 'package:dbkliknew/widgets/RegisterWidget.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RegisterWidget(),
      ),
    );
  }
}
