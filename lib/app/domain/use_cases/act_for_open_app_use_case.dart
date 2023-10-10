import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/repository_interfaces/user_repository.dart';
import 'package:mobile_app/app/domain/service_interfaces/auth_service.dart';

class ActForOpenAppUseCase {
  final AuthService _authService;
  final UserRepository _userRepository;

  call({
    required void Function(User user) whenLoggedIn,
    required void Function() whenNoLoggedIn,
}) async {
    final userId = await _authService.getLoggedInUseId();
    if(userId==null) {
      print("로그아웃 상태임");
      whenNoLoggedIn();
      return;
    }
    whenNoLoggedIn();
    return;
    final user = await _userRepository.readById(userId);
    print("로그인 상태임");
    whenLoggedIn(user);
  }

  ActForOpenAppUseCase({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;
}