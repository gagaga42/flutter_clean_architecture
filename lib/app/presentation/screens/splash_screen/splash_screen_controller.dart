import 'package:get/get.dart';
import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/use_cases/act_for_open_app_use_case.dart';
import 'package:mobile_app/routes/named_routes.dart';

class SplashScreenController extends GetxController {
  final ActForOpenAppUseCase _actForOpenAppUseCase;

  @override
  void onInit() {
    super.onInit();
    _actForOpenAppUseCase.call(
      whenLoggedIn: (user) {
        Get.put<User>(user, permanent: true);
        Get.offNamed(Routes.MAIN);
      },
      whenNoLoggedIn: () {
        Get.offNamed(Routes.FIRST);
      },
    );
  }

  SplashScreenController({
    required ActForOpenAppUseCase actForOpenAppUseCase,
  }) : _actForOpenAppUseCase = actForOpenAppUseCase;
}
