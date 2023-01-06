import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get cSize => MediaQuery.of(this).size;

  double dynamicWidth(double value) => cSize.width * value;

  double dynamicHeight(double value) => cSize.height * value;

  void to(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (c) => page),
    );
  }

  void toR(Widget page) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (c) => page),
    );
  }

  void back() {
    Navigator.of(this).pop();
  }
}
