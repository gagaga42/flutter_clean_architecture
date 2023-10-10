import 'package:hive/hive.dart';

abstract class MockDataSource {
  static Box<String> getUserBox() {
    return Hive.box<String>("user");
  }
}