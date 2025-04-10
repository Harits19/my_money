import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/app.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/util/date_util.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const testNotif = 2;

  static onDidReceiveNotificationResponse(details) {
    myLog.i("onDidReceiveNotificationResponse - ${details.toString()}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => const AddView()),
      );
    });
  }

  static onDidReceiveBackgroundNotificationResponse(details) {
    myLog.i("onDidReceiveBackgroundNotificationResponse - $details");
  }

  static Future<void> init() async {
    try {
      myLog.i("NotificationService.init start initialize notification service");
      const androidInitializationSettings =
          AndroidInitializationSettings('@mipmap/launcher_icon');

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
    String? body,
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
        testNotif, // Notification ID
        title, // Title
        body, // Body
        details,
      );
    } catch (e) {
      myLog.e("showNotification - $e");
    }
  }

  static Future<void> scheduleAllTime() async {
    // final now = TimeOfDay.now();

    final List<TimeOfDay> times = [
      const TimeOfDay(
        hour: 8,
        minute: 00,
      ),
      const TimeOfDay(
        hour: 12,
        minute: 30,
      ),
      const TimeOfDay(
        hour: 18,
        minute: 00,
      ),
      // TimeOfDay(
      //   hour: now.hour,
      //   minute: now.minute + 1,
      // ),
    ];

    for (final time in times) {
      await scheduleNotification(time);
    }
  }

  static Future<void> scheduleNotification(TimeOfDay time) async {
    try {
      // Initialize time zone data
      tz.initializeTimeZones();

      // Get the current time in the local timezone

      // final now = tz.TZDateTime.now(tz.local);
      // Set the time you want the notification to trigger (e.g., 8:00 AM)
      // final scheduledTime = now.add(const Duration(hours: 5));
      final now = DateTime.now();
      final scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      // If the scheduled time has already passed today, schedule it for the same time on the next day
      if (scheduledTime.isBefore(now)) {
        myLog.i("scheduledTime is before now");
        scheduledTime.add(const Duration(days: 1));
      }

      final parsedTime = tz.TZDateTime.from(scheduledTime, tz.local);

      const androidDetails = AndroidNotificationDetails(
        'channel_id',
        'Channel Name',
        importance: Importance.high,
        priority: Priority.high,
      );

      const platformDetails = NotificationDetails(
        android: androidDetails,
      );

      final id = time.hour * 60 + time.minute;

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id, // Notification ID
        "Add expenses", // Title
        "Remember to add your expenses today", //
        parsedTime,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents
            .time, // Set this to repeat daily at the specified time
      );
      myLog.i("parsed time ${{
        "parsedTime": parsedTime.format5(),
        "currentTime": scheduledTime.format5(),
        "id": id,
      }}");
    } catch (e) {
      myLog.e("NotificationService.scheduleNotification $e");
    }
  }
}
