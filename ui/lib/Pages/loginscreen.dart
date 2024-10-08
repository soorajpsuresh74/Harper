import 'package:flutter/material.dart';

import 'package:harper/Widget/Logiin/login_widget.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginWidget(),
    );
  }
}