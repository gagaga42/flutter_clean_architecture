import 'package:get/get.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'sign_up_screen_controller.dart';

class SignUpScreen extends GetView<SignUpScreenController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('sign_up'))
    );
  }
}


