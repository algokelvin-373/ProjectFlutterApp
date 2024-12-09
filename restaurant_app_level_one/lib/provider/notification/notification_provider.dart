import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  bool _isReminderOn = false;

  bool get isReminderOn => _isReminderOn;

  NotificationProvider() {
    _loadReminder();
  }

  Future<void> _loadReminder() async {
    print('loadReminder Jalan');
    final prefs = await SharedPreferences.getInstance();
    _isReminderOn = prefs.getBool('isReminderOn') ?? false;
    notifyListeners();
  }

  void toggleReminder() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderOn = !_isReminderOn;
    await prefs.setBool('isReminderOn', _isReminderOn);
    notifyListeners();
  }
}