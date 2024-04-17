import 'package:flutter/material.dart';
import 'package:login_demo/Helper.dart';
import 'package:login_demo/component/full_screen_text.dart';
import 'package:login_demo/db/User.dart';
import 'package:login_demo/db/UserDao.dart';
import 'package:login_demo/listitems/user_item.dart';
import 'package:login_demo/main.dart';
import 'package:login_demo/textviews/lg_text.dart';

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
  late UserDao userDao;

  _DashBoardState(this.userName);

  void handleListTileClick(int pos, User user) {
    if (user.id != null) {
      userDao.deleteUser(user.id.toString()).then((value) {
        Helper.printMessage("DB DELETE : ", "Record deleted : $value");
        if (value != null && value > 0) {
          Helper.toast(context, "User deleted successfully");
          setState(() {
            allUser.removeAt(pos);
          });
        } else {
          Helper.toast(context, "Operation failed");
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Helper.printMessage("init state", "message");
    $FloorUserDatabase.databaseBuilder("userdb.db").build().then((data) {
      userDao = data.userDao;
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
    bool userAvailable = allUser.isNotEmpty;
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
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route route) => false);
              },
              child: const Text("Logout")),
          if (userAvailable)
            Expanded(
              child: ListView.builder(
                  itemCount: allUser.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return UserItem(allUser[index], index, handleListTileClick);
                  }),
            ),
          if (!userAvailable) Expanded(child: FullScreenText("No User Found")),
          Text("Hello $userName", softWrap: true),
        ]),
      ),
    )));
  }
}
