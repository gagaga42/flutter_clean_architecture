import 'package:get/get.dart';
import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/repository_interfaces/user_repository.dart';
import 'package:mobile_app/app/domain/service_interfaces/auth_service.dart';

class SignUpUseCase {
  final UserRepository _userRepository;
  final AuthService _authService;

  Future<void> call({
    required String id,
    required String pwd,
    required String name,
    required void Function() onSuccess,
    required void Function() onFail,
}) async {
    final enrolledId = await _authService.signUp(id, pwd);
    final newUser = User(id: enrolledId, name: name);
    await _userRepository.create(newUser);
    Get.put<User>(newUser, permanent: true);
    onSuccess();
    return;
  }

  SignUpUseCase({
    required UserRepository userRepository,
    required AuthService authService,
  })  : _userRepository = userRepository,
        _authService = authService;
}