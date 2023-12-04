import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class StateDetect {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(
      {var id = 0,
      required String title,
      required String message,
      var payload,
      required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('Detect Change', 'Changed Detected',
            playSound: false,
            importance: Importance.max,
            priority: Priority.high);

    var notification = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, title, message, notification);
  }
}
