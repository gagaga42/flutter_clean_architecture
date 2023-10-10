import 'package:get/instance_manager.dart';
import 'package:mobile_app/app/data/repository_implements/user_repository_impl.dart';
import 'package:mobile_app/app/data/service_implements/auth_service_impl.dart';
import 'package:mobile_app/app/domain/use_cases/clear_all_users_use_case.dart';
import 'package:mobile_app/app/domain/use_cases/fetch_all_users_use_case.dart';
import 'package:mobile_app/app/domain/use_cases/sign_in_use_case.dart';
import 'first_screen_controller.dart';

class FirstScreenBinding implements Bindings {
  @override
  void dependencies() {
    final userRepository = UserRepositoryImpl();
    Get.put(
      FirstScreenController(
        fetchAllUsersUseCase: FetchAllUsersUseCase(
          userRepository: userRepository,
        ),
        signInUseCase: SignInUseCase(
          userRepository: userRepository,
          authService: AuthServiceImpl(),
        ),
        clearAllUserUseCase: ClearAllUserUseCase(
          userRepository: userRepository,
        ),
      ),
    );
  }
}
