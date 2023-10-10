import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/repository_interfaces/user_repository.dart';

class FetchAllUsersUseCase {
  final UserRepository _userRepository;

  Future<List<User>> call() async {
    return await _userRepository.readAll();
  }

  FetchAllUsersUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
}