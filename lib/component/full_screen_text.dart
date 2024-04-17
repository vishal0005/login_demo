import 'package:flutter/material.dart';
import 'package:login_demo/textviews/lg_text.dart';

class FullScreenText extends StatelessWidget {
  String message;

  FullScreenText(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
            child: Container(alignment: Alignment.center,
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(color: Colors.black),
                child: LgText(message, Colors.white))));
  }
}
