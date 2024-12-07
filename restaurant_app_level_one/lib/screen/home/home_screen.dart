import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/provider/notification/notification_provider.dart';
import 'package:restaurant_app_level_one/provider/theme/theme_provider.dart';
import 'package:restaurant_app_level_one/screen/home/home_screen_body_widget.dart';
import 'package:restaurant_app_level_one/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*bool _isReminderOn = false;

  @override
  void initState() {
    super.initState();
    _loadReminderPreference();
  }

  Future<void> _loadReminderPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isReminderOn = prefs.getBool('dailyReminder') ?? false;
    });
  }

  Future<void> _updateReminderPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dailyReminder', value);
    setState(() {
      _isReminderOn = value;
    });
    if (value) {
      _scheduleDailyReminder();
    } else {
      _cancelDailyReminder();
    }
  }

  void _scheduleDailyReminder() {
    print('Reminder Scheduled at 11:00 AM');
    NotificationService.scheduleNotification();
  }

  void _cancelDailyReminder() {
    print('Reminder Canceled');
    NotificationService.cancelNotification();
  }*/

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant App"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: Icon(
              themeProvider.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: themeProvider.isDarkMode ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              notificationProvider.toggleReminder();
              if (notificationProvider.isReminderOn) {
                NotificationService.scheduleNotification();
              } else {
                NotificationService.cancelNotification();
              }
            },
            icon: Icon(
              notificationProvider.isReminderOn ? Icons.notifications : Icons.notifications_off,
              color: notificationProvider.isReminderOn ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
      body: const HomeScreenBodyWidget(),
    );
  }
}