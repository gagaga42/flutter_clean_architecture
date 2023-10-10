import 'package:mobile_app/app/domain/repository_interfaces/user_repository.dart';
import 'package:mobile_app/app/domain/service_interfaces/auth_service.dart';
import 'package:mobile_app/app/mock_auth_data_source.dart';

class ClearAllUserUseCase {
  final UserRepository _userRepository;

  Future<void> call({
    required void Function() afterClear
}) async {
    await _userRepository.deleteAllUser();
    // 이거 안티패턴인데 걍 이렇게 함 귀찮아서
    await MockAuthDataSource.deleteAll();
    afterClear();
  }

  ClearAllUserUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
}