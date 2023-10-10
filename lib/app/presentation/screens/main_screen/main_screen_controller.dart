import 'package:get/get.dart';
import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/use_cases/sign_out_use_case.dart';
import 'package:mobile_app/app/presentation/screens/first_screen/first_screen_controller.dart';
import 'package:mobile_app/routes/named_routes.dart';

class MainScreenController extends GetxController {
  final SignOutUseCase _signOutUseCase;
  final _user = Get.find<User>();

  String get userId => _user.id;

  String get userName => _user.name;

  void onSignOutButtonTap() {
    _signOutUseCase.call(
      userId,
      () {
        Get.offNamed(Routes.FIRST);
      },
    );
  }

  MainScreenController({
    required SignOutUseCase signOutUseCase,
  }) : _signOutUseCase = signOutUseCase;
}
