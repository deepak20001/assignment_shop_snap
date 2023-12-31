import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushAndRemoveUntil(
      {required Widget widget, required BuildContext context}) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => widget), (route) => false);
  }

  Future<dynamic> push(
      {required Widget widget, required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => widget),
    );
  }

  Future<dynamic> pushReplacement(
      {required Widget widget, required BuildContext context}) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => widget),
    );
  }
}
