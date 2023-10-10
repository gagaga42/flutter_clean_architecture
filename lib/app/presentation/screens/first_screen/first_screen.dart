import 'package:get/get.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'first_screen_controller.dart';

class FirstScreen extends GetView<FirstScreenController> {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInformBox(),
              TextFormField(
                decoration: const InputDecoration(labelText: "아이디"),
                controller: controller.idCon,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "비밀번호"),
                controller: controller.pwdCon,
              ),
              const SizedBox(height: 20),
              Obx(
                () =>
                    // Elevated Button은 OnPressed가 null이면 알아서 disable 상태에
                    // 돌입한다
                    ElevatedButton(
                  onPressed: controller.canLogin ? controller.onSignInButtonTap : null,
                  child: const Text("로그인"),
                ),
              ),
              TextButton(
                onPressed: controller.onSignUpButtonTap,
                child: const Text("회원가입"),
              ),
              const SizedBox(height: 40),
              // 이런식으로 Widget을 리턴하는 메소드를 만들어서 코드를 좀 더 깔끔하고
              // 보기 쉽게 유지할 수 있습니다
              // 다만 컨벤션 상, Obx나 Expanded 같이 바로 맥락을 파악할 수 있는 위젯은
              // 바깥에 선언을 해주는 것이 좋습니다,
              Obx(() => _buildUserListTile()),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildUserListTile() {
    if (controller.users.isEmpty) {
      return const Text("유저 없음");
    }
    return Container(
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "로컬 디비에 저장된 유저 목록",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: controller.onClearButtonTap,
                child: const Text(
                  "유저 다 지우기",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          const Text("(원래였으면 서버에 저장되어야 하는 것들, 임시로 이렇게 보여줌)"),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              clipBehavior: Clip.hardEdge,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: controller.users
                  .map(
                    (user) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.5)
                      ),
                      child: Text("name: ${user.name}, id: ${user.id}"),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),

      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("현재 커밋 버전에서는 회원가입과 로그인 로그아웃 등 기보적인"),
          Text("auth 시스템을 구현하였습니다."),
          Text("외부 서버를 요청할 수 없어서 임시로 'mockAuthDataSource', 'mockDataSource'라는걸 만들어서 했습니다"),
          Text("data layer 참고하시면 됩니다."),
        ],
      ),
    );
  }
}

// TODO 여기 주목 - 하단의 주석처리된 친구를 복사 해서 get_pages.dart로 ㄱㄱ
// GetPage(
//   name: ,
//   page: () => const FirstScreen(),
//   binding: FirstScreenBinding(),
// )
