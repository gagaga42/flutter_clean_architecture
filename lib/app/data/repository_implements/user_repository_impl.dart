import 'dart:convert';

import 'package:mobile_app/app/domain/models/user.dart';
import 'package:mobile_app/app/domain/repository_interfaces/user_repository.dart';
import 'package:mobile_app/app/mock_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> create(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final box = MockDataSource.getUserBox();
    box.put(user.id, jsonEncode(user.toMap()));
    return;
  }

  @override
  Future<User> readById(String userId) {
    final box = MockDataSource.getUserBox();
    final userJson = box.get(userId);
    if (userJson==null) throw AssertionError("엥 이거 뭔가 잘못됐다");
    return Future.value(User.fromMap(jsonDecode(userJson)));
  }

  @override
  Future<List<User>> readAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final box = MockDataSource.getUserBox();
    final userJsons = box.values;
    final users = userJsons.map((json) => User.fromMap(jsonDecode(json))).toList();
    return users;
  }

  @override
  Future<void> deleteAllUser() {
    final box = MockDataSource.getUserBox();
    box.clear();
    return Future.value();
  }
  
}