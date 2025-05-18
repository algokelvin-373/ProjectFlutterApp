import 'package:flutter/material.dart';

EdgeInsets verticalSymmetric(double padding) {
  return EdgeInsets.symmetric(vertical: padding);
}

EdgeInsets horizontalSymmetric(double padding) {
  return EdgeInsets.symmetric(horizontal: padding);
}

SizedBox spaceVertical(double height) {
  return SizedBox(height: height);
}

SizedBox spaceHorizontal(double width) {
  return SizedBox(width: width);
}

Align textCenter(String text) {
  return Align(
    alignment: Alignment.center,
    child: Text(text, style: const TextStyle(fontSize: 20)),
  );
}

SizedBox lines() {
  return SizedBox(height: 1, child: Container(color: Colors.grey));
}
