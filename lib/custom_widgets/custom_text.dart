import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String string;
  Color color;
  double fontSize;

  CustomText({
  required this.string,
this.fontSize = 20,
    this.color = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return Text(string,style: TextStyle(
        color: color,
        fontSize: fontSize),
        );
  }
}
