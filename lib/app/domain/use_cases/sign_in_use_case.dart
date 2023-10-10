import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/repository_interfaces/user_repository.dart';
import 'package:mobile_app/app/domain/result.dart';
import 'package:mobile_app/app/domain/service_interfaces/auth_service.dart';

class SignInUseCase {
  final AuthService _authService;
  final UserRepository _userRepository;

  SignInUseCase({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  call({
    required String id,
    required String pwd,
    required void Function() whenNoUser,
    required void Function() whenWrongPwd,
    required void Function() onFail,
    required void Function(User user) onSuccess,
}) async {
    final resultOfAuthSignIn = await _authService.signIn(id, pwd);

    switch( resultOfAuthSignIn) {
      case Success(:final data) :{
        final user = await _userRepository.readById(data);
        onSuccess(user);
      }
      case Fail(:final issue) : {
        switch(issue) {
          case SignInIssue.wrongPwd :
            whenWrongPwd();
          case SignInIssue.idNotExists :
            whenNoUser();
          case SignInIssue.unknown :
            onFail();
        }
      }
    }

  }
}