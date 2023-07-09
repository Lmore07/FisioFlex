import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast(String msg, {Color? backgroundColor, Color? foregroundColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.black,
    textColor: foregroundColor ?? Colors.white,
    fontSize: 16.0,
  );
}
