import 'package:flutter/material.dart';
import 'package:login_demo/Helper.dart';
import 'package:login_demo/main.dart';

class DashBoard extends StatelessWidget {
  final String userName;

  const DashBoard(this.userName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      constraints: const BoxConstraints.expand(),
      child: Container(alignment: Alignment.topLeft,
        decoration: const BoxDecoration(color: Colors.red),
        child: Column(children: [
          Text("Hello $userName", softWrap: true),
          TextButton(
              onPressed: () {
                Helper.logOut(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route route) => false);
              },
              child: const Text("Logout"))
        ]),
      ),
    )));
  }
}
