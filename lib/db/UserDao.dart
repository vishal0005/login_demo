import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:login_demo/db/User.dart';

@dao
abstract class UserDao {
  @insert
  Future<int> insertUser(User user);

  @Query("select * from User")
  Future<List<User>> getAllUser();

  @Query("select * from User where name = :name AND password=:pass")
  Future<List<User>> getSelectedUser(String name, String pass);
}
