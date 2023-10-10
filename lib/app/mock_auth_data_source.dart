import 'dart:convert';

import 'package:hive/hive.dart';

class MockAuthDataSource {
  static final _authTable = Hive.box<String>("auth");

  static bool checkIdExists(String userId) {
   return _authTable.keys.contains(userId);
  }

  static Future<void> enrollAuthRow(String id, String pwd) async {
    await _authTable.put(id, _encodePwd(pwd));
  }



  static String? checkPwd(String id, String pwd) {
    final encryptedPwd = _getEncryptedPwdById(id);
    if (encryptedPwd== null) {
      return null;
    }
    final encryptedPwdForCheck =_encodePwd(pwd);
    if (encryptedPwdForCheck == encryptedPwd) {
      return id;
    }
  }
  static String? _getEncryptedPwdById(String id) {
    return _authTable.get(id);
  }

  static String _encodePwd(String pwd) {
    final bytes = utf8.encode(pwd);
    final base64Str = base64.encode(bytes);
    return base64Str;
  }

  static Future<void> deleteAll() async {
    await _authTable.clear();
  }
}

class AuthPair {
  final String id;
  final String encryptedPwd;

  AuthPair({
    required this.id,
    required this.encryptedPwd,
  });
}