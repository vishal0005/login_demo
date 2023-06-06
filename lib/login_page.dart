import 'package:flutter/material.dart';
import 'package:login_demo/Helper.dart';
import 'package:login_demo/db/UserDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserDatabase userDb;

  var nameController = TextEditingController();

  var passController = TextEditingController();
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    $FloorUserDatabase
        .databaseBuilder("userdb.db")
        .build()
        .then((value) => userDb = value);
    SharedPreferences.getInstance().then((prefs) {
      setState(() => preferences = prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter password"),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  onLoginClick(context);
                },
                child: const Text("Login")),
          ],
        )),
      ),
    );
  }

  void onLoginClick(BuildContext context) {
    var name = nameController.text;
    var pass = passController.text;
    userDb.userDao.getSelectedUser(name, pass).then((value) {
      if (value.isNotEmpty) {
        String saveName = value[0].name;
        String savePass = value[0].password;
        if (name.isEmpty) {
          Helper.toast(context, "Please enter name");
        } else if (pass.isEmpty) {
          Helper.toast(context, "Please enter password");
        } else if (pass.length != 4) {
          Helper.toast(context, "Please enter 4 digit password");
        } else if (saveName == name && savePass == pass) {
          Helper.toast(context, "Login user successfully");
        } else {
          Helper.toast(context, "Name and password not match");
        }
      } else {
        Helper.toast(context, "Name and password not match");
      }
    });
  }
}
