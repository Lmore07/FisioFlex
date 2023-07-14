import 'package:flutter/material.dart';

Widget spaced(double? height, double? width) {
  return SizedBox(
    height: height,
    width: width,
  );
}

Color backgroundColor = Color.fromRGBO(156, 211, 221, 1);

Color backgroundColorHeader = Color.fromRGBO(0, 123, 189, 1);

Color buttonColor = Color.fromRGBO(0, 168, 214, 1);

Color buttonVoiceColor = Color.fromRGBO(245, 176, 97, 1);

Color buttonFinishColor = Color.fromRGBO(55, 197, 84, 1);

Color buttonLogOutColor = Color.fromRGBO(253, 66, 66, 1);

Color cardColor = Color.fromRGBO(248, 184, 48, 1);

TextStyle textStyleTitleHeader =
    TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white);

TextStyle textTitleStyleCard =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);

TextStyle textSubtitleStyleCard =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300);

TextStyle textStyleButtonFinishAndVoiceAndLogOut(Color textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
}

TextStyle textStyleTittle =
    TextStyle(fontSize: 22, fontWeight: FontWeight.w800);

TextStyle textStyleLabels = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: Color(0xFF2F2F2F),
  fontFamily: 'Nunito',
);

TextStyle styleButton(Color buttonColor) {
  return TextStyle(
    color: buttonColor,
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
}
