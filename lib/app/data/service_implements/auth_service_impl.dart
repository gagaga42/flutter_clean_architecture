import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/app/domain/result.dart';
import 'package:mobile_app/app/domain/service_interfaces/auth_service.dart';
import 'package:mobile_app/app/mock_auth_data_source.dart';

class AuthServiceImpl implements AuthService {
  final _storage = const FlutterSecureStorage();
  @override
  Future<Result<String,SignInIssue>> signIn(String id, String pwd) async {
    final checkIdExists = MockAuthDataSource.checkIdExists(id);
    if (!checkIdExists) {
      return Fail(SignInIssue.idNotExists);
    }
    final checkPwd = MockAuthDataSource.checkPwd(id, pwd);
    if (checkPwd!=null) {
      _storage.write(key: "access", value: checkPwd);
      return Success(id);
    }
    return Fail(SignInIssue.wrongPwd);
  }

  @override
  Future<String> signUp(String id, String pwd) async {
    await MockAuthDataSource.enrollAuthRow(id, pwd);
    await _storage.write(key: "access", value: id);
    return id;
  }

  @override
  Future<void> signOut() async {
    _storage.delete(key: "access");
  }

  @override
  Future<String?> getLoggedInUseId() async {
    return await _storage.read(key: 'access');
  }

}