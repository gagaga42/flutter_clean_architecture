import 'package:mobile_app/app/domain/models/user.dart';

abstract class UserRepository {
  Future<User> readById(String userId);
  Future<List<User>> readAll();
  Future<void> create(User user);
  Future<void> deleteAllUser();
}