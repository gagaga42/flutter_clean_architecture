import 'package:get/get.dart';
import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/service_interfaces/auth_service.dart';

class SignOutUseCase {
  final AuthService _authService;

  Future<void> call(
    String id,
    void Function() afterSingOut,
  ) async {
    _authService.signOut();
    Get.delete<User>(force: true);
    afterSingOut();
  }

  const SignOutUseCase({
    required AuthService authService,
  }) : _authService = authService;
}
