import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomEasyLoading {
  static final instance = CustomEasyLoading._internal();

  CustomEasyLoading._internal() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.chasingDots
      ..indicatorSize = 45.0
      ..radius = 15.0;
  }

  void showLoading(String message) {
    EasyLoading.instance
      ..backgroundColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.green
      ..progressColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.5);
    EasyLoading.show(status: message, maskType: EasyLoadingMaskType.custom);
  }

  void showSuccess(String message) {
    EasyLoading.instance
      ..backgroundColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60.0
      ..indicatorWidget = Icon(Icons.check_circle_outline)
      ..textColor = Colors.black
      ..textStyle = TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)
      ..indicatorColor = Colors.green;
    EasyLoading.showSuccess(message,
        maskType: EasyLoadingMaskType.black, duration: Duration(seconds: 1));
  }

  void showError(String message) {
    EasyLoading.instance
      ..backgroundColor = Colors.red
      ..indicatorWidget = Icon(Icons.error)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..textStyle = TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);
    EasyLoading.showError(message,
        maskType: EasyLoadingMaskType.black, duration: Duration(seconds: 1));
  }

  void dismiss() {
    EasyLoading.dismiss();
  }
}
