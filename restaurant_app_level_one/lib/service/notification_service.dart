import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(settings);
    tz.initializeTimeZones();
  }

  static Future<void> scheduleNotification() async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      23, // Jam 9 malam (21:00)
      22, // Menit 0
    );
    print("Notifikasi dijadwalkan pada: $scheduledTime");

    // Jika waktu telah lewat hari ini, jadwalkan untuk esok hari
    final adjustedTime =
    scheduledTime.isBefore(now) ? scheduledTime.add(Duration(days: 1)) : scheduledTime;

    await _notifications.zonedSchedule(
      0,
      'Daily Reminder',
      'Jangan lupa untuk bersiap tidur!',
      adjustedTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminder',
          channelDescription: 'Channel for daily reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexact,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelNotification() async {
    await _notifications.cancel(0);
  }
}