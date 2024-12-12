import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/notification/notification_provider.dart';
import '../../provider/theme/theme_provider.dart';
import '../../service/notification_service.dart';
import 'home_screen_body_widget.dart';

class HomeScreen extends StatelessWidget {
  final Function(String) onTapped;

  const HomeScreen({
    super.key,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Story App"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
              color: themeProvider.isDarkMode ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () async {
              print('Click for notification');
              notificationProvider.toggleReminder();
              if (!notificationProvider.isReminderOn) {
                print('Click for scheduleNotification');
                await NotificationService.scheduleNotification();
              } else {
                print('Click for cancelNotification');
                await NotificationService.cancelNotification();
              }
            },
            icon: Icon(
              notificationProvider.isReminderOn
                  ? Icons.notifications_active
                  : Icons.notifications,
              color:
                  notificationProvider.isReminderOn ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
      body: HomeScreenBodyWidget(onTapped: onTapped),
    );
  }
}
