import 'package:get/get.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'main_screen_controller.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('로그인됨'),
          Text(controller.userId),
          Text(controller.userName),
          ElevatedButton(
            onPressed: controller.onSignOutButtonTap,
            child: const Text(
              "로그아웃",
            ),
          ),
        ],
      ),
    ));
  }
}
