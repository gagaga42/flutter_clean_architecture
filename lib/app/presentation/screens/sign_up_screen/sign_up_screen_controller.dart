import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/domain/use_cases/sign_up_use_case.dart';
import 'package:mobile_app/app/presentation/screens/first_screen/first_screen_controller.dart';
import 'package:mobile_app/routes/named_routes.dart';

class SignUpScreenController extends GetxController {
  final SignUpUseCase _signUpUseCase;

  final idCon = TextEditingController();
  bool _idNotEmpty = false;
  final nameCon = TextEditingController();
  bool _nameNotEmpty = false;
  final pwdCon = TextEditingController();
  bool _pwdNotEmpty = false;
  final pwdCheckCon = TextEditingController();
  bool _pwdCheckNotEmpty = false;

  bool get allowSubmit => _idNotEmpty && _nameNotEmpty && _pwdNotEmpty && _pwdCheckNotEmpty;

  @override
  void onInit() {
    super.onInit();
    idCon.addListener(() {
      // bool 만 저장함.
      _idNotEmpty = idCon.text.isNotEmpty;
      // 좋지 않은 방식이나 매번 업데이트 시킴 - 다른 상태 및 뷰 관리를 시범 보이기
      // 이것은 obs 변수를 활용하지 않는 단순 상태 관리
      update();
    });
    nameCon.addListener(() {
      _nameNotEmpty = nameCon.text.isNotEmpty;
      update();
    });
    pwdCon.addListener(() {
      _pwdNotEmpty = pwdCon.text.isNotEmpty;
      update();
    });
    pwdCheckCon.addListener(() {
      _pwdCheckNotEmpty = pwdCheckCon.text.isNotEmpty;
      update();
    });
  }

  @override
  void onClose() {
    super.onClose();
    idCon.dispose();
    nameCon.dispose();
    pwdCon.dispose();
    pwdCheckCon.dispose();
  }

  void onSubmit() {
    // 추후 여기에 실제 로직을 추가하겠음
    // 그리고 이런 식으로 현재 text controller에 담긴 값을 가져올 수 있음.
    final id = idCon.text;
    final name = nameCon.text;
    final pwd = pwdCon.text;
    final pwdCheck = pwdCheckCon.text;
    if (pwd != pwdCheck) {
      Get.snackbar('에러', '비밀번호 확인과 비밀번호가 다름');
      return;
    }
    _signUpUseCase.call(
      id: id,
      pwd: pwd,
      name: name,
      onSuccess: () {
        Get.offNamed(Routes.MAIN);
        Get.find<FirstScreenController>().fetchUsers();
      },
      onFail: () {
        Get.snackbar('에러', '회원가입 실패');
      }
    );
  }

  SignUpScreenController({
    required SignUpUseCase signUpUseCase,
  }) : _signUpUseCase = signUpUseCase;
}
