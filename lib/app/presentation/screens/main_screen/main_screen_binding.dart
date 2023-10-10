import 'package:get/instance_manager.dart';
import 'package:mobile_app/app/data/service_implements/auth_service_impl.dart';
import 'package:mobile_app/app/domain/use_cases/sign_out_use_case.dart';
import 'main_screen_controller.dart';

class MainScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      MainScreenController(
        signOutUseCase: SignOutUseCase(
          authService: AuthServiceImpl(),
        ),
      ),
    );
  }
}
