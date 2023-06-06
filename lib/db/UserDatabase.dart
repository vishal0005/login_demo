import 'package:floor/floor.dart';
import 'package:login_demo/db/User.dart';
import 'package:login_demo/db/UserDao.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'UserDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [User])
abstract class UserDatabase extends FloorDatabase {
  UserDao get userDao;
}
