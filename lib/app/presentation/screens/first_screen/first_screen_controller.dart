import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/use_cases/clear_all_users_use_case.dart';
import 'package:mobile_app/app/domain/use_cases/fetch_all_users_use_case.dart';
import 'package:mobile_app/app/domain/use_cases/sign_in_use_case.dart';
import 'package:mobile_app/routes/named_routes.dart';

class FirstScreenController extends GetxController {
  final FetchAllUsersUseCase _fetchAllUsersUseCase;
  final SignInUseCase _signInUseCase;
  final ClearAllUserUseCase _clearAllUserUseCase;

  final TextEditingController idCon = TextEditingController();
  final TextEditingController pwdCon = TextEditingController();

  final _id = "".obs;
  final _pwd = "".obs;

  final users = <User>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchUsers();
  }

  bool get canLogin => _id.value.isNotEmpty && _pwd.value.isNotEmpty;

  void onSignUpButtonTap() {
    // 우리 플젝에서 페이지 이동할 때에는 항상 아래 형식을 따른다
    // toNamed에는 string이 들어가는데, Routes.Maker 메소드를
    // 활용하여 다음 화면의 url을 알아서 조합하여 만들어준다.
    Get.toNamed(Routes.Maker(nextRoute: Routes.SIGN_UP));
  }

  void fetchUsers() async {
    final users = await _fetchAllUsersUseCase.call();
    this.users(users);
  }

  void onSignInButtonTap() {
    _signIn();
  }

  void _signIn() {
    _signInUseCase.call(
      id: _id.value,
      pwd: _pwd.value,
      whenNoUser: () {
        Get.snackbar('엥', '없는디?');
      },
      whenWrongPwd: () {
        Get.snackbar('엥', '비번틀림');
      },
      onFail: () {
        Get.snackbar('엥', '왜 안됨?');
      },
      onSuccess: (user) {
        // sign up use case에서는 Get.put을 유즈케이스 내부에서 했는데
        // 여기서는 뷰에서 함. 이거는 사실 취향? 흠 아직 논란이 있어서
        // 우리끼리 합의를 정확히 못 봄
        Get.put<User>(user, permanent: true);
        Get.offNamed(Routes.MAIN);
      },
    );
  }

  void onClearButtonTap() {
    _clearAllUserUseCase.call(
      afterClear: () {
        users([]);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    print("first screen");
    idCon.addListener(() {
      _id(idCon.text);
    });
    pwdCon.addListener(() {
      _pwd(pwdCon.text);
    });
  }

  @override
  void onClose() {
    super.onClose();
    // 이거 해줘야 메모리 누수를 막을 수 있음
    idCon.dispose();
    pwdCon.dispose();
  }

  FirstScreenController({
    required FetchAllUsersUseCase fetchAllUsersUseCase,
    required SignInUseCase signInUseCase,
    required ClearAllUserUseCase clearAllUserUseCase,
  })  : _fetchAllUsersUseCase = fetchAllUsersUseCase,
        _clearAllUserUseCase = clearAllUserUseCase,
        _signInUseCase = signInUseCase;
}
