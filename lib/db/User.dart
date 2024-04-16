import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @primaryKey
  final String name;
  final String password;

  User(this.id, this.name, this.password);
}