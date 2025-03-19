import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onDidReceiveNotificationResponse(details) {
    myLog.i("onDidReceiveNotificationResponse - $details");
  }

  static onDidReceiveBackgroundNotificationResponse(details) {
    myLog.i("onDidReceiveBackgroundNotificationResponse - $details");
  }

  static init() async {
    try {
      const androidInitializationSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const initializationSettings =
          InitializationSettings(android: androidInitializationSettings);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse,
      );
    } catch (e) {
      myLog.e("NotificationService.init - $e");
    }
  }

  static Future<void> requestPermission() async {
    try {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } catch (e) {
      myLog.e("requestPermission - error ${e.toString()}");
    }
  }

  static void showNotification({
    required String title,
    required String body,
  }) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'channel_id',
        'Channel Name',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails details =
          NotificationDetails(android: androidDetails);

      await flutterLocalNotificationsPlugin.show(
        123, // Notification ID
        title, // Title
        body, // Body
        details,
      );
    } catch (e) {
      myLog.e("showNotification - $e");
    }
  }

  static Future<void> scheduleNotification() async {
    try {
      // Initialize time zone data
      tz.initializeTimeZones();

      // Get the current time in the local timezone
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

      // Set the time you want the notification to trigger (e.g., 8:00 AM)
      final tz.TZDateTime scheduledTime = tz.TZDateTime(
          tz.local, now.year, now.month, now.day, 21, 55); // 8:00 AM today

      // If the scheduled time has already passed today, schedule it for the same time on the next day
      if (scheduledTime.isBefore(now)) {
        scheduledTime.add(const Duration(days: 1));
      }

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'channel_id',
        'Channel Name',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // Notification ID
        'Scheduled Notification', // Title
        'This notification will appear in 5 seconds.', // Body
        scheduledTime, // The time you want the notification to appear
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.inexact,
        matchDateTimeComponents: DateTimeComponents
            .time, // Set this to repeat daily at the specified time
      );

      myLog.i(
          'Notification scheduled for: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(scheduledTime)}');
    } catch (e) {
      myLog.e("NotificationService.scheduleNotification $e");
    }
  }
}
