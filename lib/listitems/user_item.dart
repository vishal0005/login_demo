import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_demo/textviews/lg_text.dart';

class UserItem extends StatelessWidget {
  String title;
  String description;

  UserItem(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.yellow),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.blue),
            child: Row(
              children: [
                // Wrap your first row widgets in a Row
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: LgText(description, Colors.black)),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: LgText(title, Colors.black)),
                      // Elements for your first row (e.g., Text, Icon, etc.)
                    ],
                  ),
                ),
                const Image(
                  width: 50,
                  height: 50,
                  image: AssetImage("assets/icons/icon_delete.png"),
                ),
              ],
            ),

            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Flexible(
            //       child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 10, vertical: 10),
            //           child: LgText(description, Colors.black)),
            //     ),
            //     Flexible(
            //       child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 10, vertical: 10),
            //           child: LgText(title, Colors.black)),
            //     ),
            //     Container(constraintsdecoration: BoxDecoration(color: Colors.yellow),child: const Image(width: 50,height: 50,image: AssetImage("assets/icons/icon_delete.png"),))
            //   ],
            // ),
          ),
          const Divider(height: 2, thickness: 2, color: Colors.black)
        ],
      ),
    );
  }
}
