import 'package:flutter/material.dart';
import 'package:login_demo/Helper.dart';
import 'package:login_demo/component/full_screen_text.dart';
import 'package:login_demo/db/User.dart';
import 'package:login_demo/listitems/user_item.dart';
import 'package:login_demo/main.dart';

import 'db/UserDatabase.dart';

class DashBoard extends StatefulWidget {
  final String userName;

  const DashBoard(this.userName, {super.key});

  @override
  State<StatefulWidget> createState() => _DashBoardState(userName);
}

class _DashBoardState extends State<DashBoard> {
  late String userName;
  List<User> allUser = List.empty();

  _DashBoardState(this.userName);

  @override
  void initState() {
    super.initState();
    Helper.printMessage("init state", "message");
    $FloorUserDatabase.databaseBuilder("userdb.db").build().then((data) {
      data.userDao.getAllUser().then((value) {
        setState(() {
          // _data = data;
          allUser = value;
        });
      });
    }).catchError((error) {
      // Handle errors here
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allUser.isNotEmpty) {
      return Scaffold(
          body: SafeArea(
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Column(children: [
                    Text("Hello $userName", softWrap: true),
                    TextButton(
                        onPressed: () {
                          Helper.logOut(context);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                                  (Route route) => false);
                        },
                        child: const Text("Logout")),
                    Expanded(
                      child: ListView.builder(
                          itemCount: allUser.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            String? name = allUser[index].name;
                            // return ListTile(title: Text("user name : $name"));
                            return UserItem(allUser[index].name, allUser[index].id.toString());
                          }),
                    ),
                    Text("Hello $userName", softWrap: true)
                  ]),
                ),
              )));
    } else {
      Helper.printMessage(
          "All User", "all user size non : ${allUser.length}");
      return FullScreenText("No data");
    }
  }
}
