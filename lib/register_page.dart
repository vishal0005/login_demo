import 'package:flutter/material.dart';
import 'package:login_demo/dashboard.dart';
import 'package:login_demo/Helper.dart';
import 'package:login_demo/db/User.dart';

import 'db/UserDatabase.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late UserDatabase userDb;

  var nameController = TextEditingController();

  var passController = TextEditingController();

  var passConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    $FloorUserDatabase
        .databaseBuilder("userdb.db")
        .build()
        .then((value) => userDb = value);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start, children: [
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
              TextField(
                controller: passConfirmController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter confirm password"),
              ),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    onRegisterClick(context);
                  },
                  child: const Text("Register")),
            ]),
          ),
        ));
  }

  void onRegisterClick(BuildContext context) {
    var name = nameController.text;
    var pass = passController.text;
    var passConfirm = passConfirmController.text;
    if (name.isEmpty) {
      toast(context, "Please enter name");
    } else if (pass.isEmpty || passConfirm.isEmpty) {
      toast(context, "Please enter password");
    } else if (pass.length != 4 || passConfirm.length != 4) {
      toast(context, "Please enter 4 digit password");
    } else if (pass != passConfirm) {
      toast(context, "Please confirm password");
    } else {
      Helper.saveUser(name);
      Helper.savePassword(pass);
      userDb.userDao.insertUser(User(null, name, pass)).then((value) =>
      {
        Helper.printMessage("Add user : ", "$value")
        // toast(context, "added array : $value")
      }).catchError((error) => {
      Helper.printMessage("Add user : catchError", "$error")
      }).onError((error, stackTrace) =>
      {
        Helper.printMessage("Add user : onError", "$error")
      });
      toast(context, "Register user successfully");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => DashBoard(name)),
              (Route route) => false);
    }
  }

  void toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
