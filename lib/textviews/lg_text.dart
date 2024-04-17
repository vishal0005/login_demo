import 'package:flutter/material.dart';

class LgText extends StatelessWidget {
  String text;
  Color textColor;

  LgText(this.text, this.textColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: textColor),
    );
  }
}
