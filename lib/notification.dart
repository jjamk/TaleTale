import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));

    await flutterLocalNotificationsPlugin.show(
        0,
        '같이탈래 배차완료!',
        '신청하신 [동서울-이천] 6월24일 11시 30분 노선이 신설되었어요. 예매하러 가볼까요?',
        notificationDetails);
    ;
  }
}
