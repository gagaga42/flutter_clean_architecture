import 'package:mobile_app/app/domain/result.dart';

abstract class AuthService {
  // Auth service 는 보통
  // 로컬 보안 저장소 1개와, 서버에서의 Auth 테이블과 관계를 맺는다.
  Future<Result<String, SignInIssue>> signIn(String id, String pwd);
  Future<String> signUp(String id, String pwd);
  Future<void> signOut();
  Future<String?> getLoggedInUseId();
}

enum SignInIssue {
  wrongPwd,
  idNotExists,
  unknown,
}