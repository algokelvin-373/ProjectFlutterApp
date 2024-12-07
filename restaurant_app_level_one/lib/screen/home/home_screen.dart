import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/provider/notification/local_notification_provider.dart';
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

  Future<void> _scheduleDailyTenAMNotification() async {
    // todo-03-action-01: run a schedule notification
    context.read<LocalNotificationProvider>().scheduleDailyTenAMNotification();
  }

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
          ElevatedButton(
            onPressed: () async {
              await _scheduleDailyTenAMNotification();
            },
            child: const Text(
              "Schedule",
              textAlign: TextAlign.center,
            ),
          ),
          /*IconButton(
            onPressed: () async {
              print('Click for notification');
              await _scheduleDailyTenAMNotification();
              *//*notificationProvider.toggleReminder();
              if (notificationProvider.isReminderOn) {
                await NotificationService.scheduleNotification();
              } else {
                await NotificationService.cancelNotification();
              }*//*
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
          ),*/
        ],
      ),
      body: const HomeScreenBodyWidget(),
    );
  }
}