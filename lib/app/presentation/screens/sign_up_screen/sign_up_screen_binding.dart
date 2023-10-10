import 'package:get/instance_manager.dart';
import 'package:mobile_app/app/data/repository_implements/user_repository_impl.dart';
import 'package:mobile_app/app/data/service_implements/auth_service_impl.dart';
import 'package:mobile_app/app/domain/use_cases/sign_up_use_case.dart';
import 'sign_up_screen_controller.dart';

class SignUpScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignUpScreenController(signUpUseCase: SignUpUseCase(userRepository: UserRepositoryImpl(), authService: AuthServiceImpl())
    ));
  }
}