// ignore_for_file: public_member_api_docs

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  static Future init({bool scheduled = false}) async {
    tz.initializeTimeZones();
    var initAndroidSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = const IOSInitializationSettings();
    final settings =
        InitializationSettings(android: initAndroidSettings, iOS: ios);
    await _notification.initialize(settings,
        onSelectNotification: onSelectedNotification);
  }

  static Future showNotification({
    var id = 0,
    var title,
    var body,
    var payload,
  }) async {
    final details = await notificationDetails();
    await _notification.show(id, title, body, details);
  }

  static Future showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      var payload,
      tz.TZDateTime? time}) async {
    final details = await notificationDetails();

    // await _notification.showDailyAtTime(
    //     id, title, body, Time(timeOfDay!.hour, timeOfDay!.minute), details);
    await _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.local(DateTime.now().year, selected!.month, selected!.day,
                timeOfDay!.hour, timeOfDay!.minute)
            .subtract(DateTime.now().timeZoneOffset),
        details,
        payload: payload,
        matchDateTimeComponents: repeatNotification,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'Description',
            importance: Importance.max,
            priority: Priority.max,
            
            playSound: true),
        iOS: IOSNotificationDetails());
  }

  static void onSelectedNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
}
