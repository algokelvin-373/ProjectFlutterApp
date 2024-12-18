import 'package:flutter/material.dart';

class SnackBarHelper {
  final BuildContext context;

  SnackBarHelper(this.context);

  void showMessage(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
