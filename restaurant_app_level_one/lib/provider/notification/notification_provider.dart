import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  bool _isReminderOn = false;

  bool get isReminderOn => _isReminderOn;

  void toggleReminder() {
    _isReminderOn = !_isReminderOn;
    notifyListeners();
  }
}