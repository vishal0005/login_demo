import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {

  static Future<bool> saveUser(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString("name", name);
  }

  static Future<String?> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("name");
  }

  static Future<bool> savePassword(String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString("pass", pass);
  }

  static Future<String?> getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("pass");
  }

  static void toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
