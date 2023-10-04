import 'package:get/get.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'first_screen_controller.dart';

class FirstScreen extends GetView<FirstScreenController> {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('first'))
    );
  }
}

// TODO 여기 주목 - 하단의 주석처리된 친구를 복사 해서 get_pages.dart로 ㄱㄱ
// GetPage(
//   name: ,
//   page: () => const FirstScreen(),
//   binding: FirstScreenBinding(),
// )
