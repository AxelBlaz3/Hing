import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> init() async {
    //Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification.png');

    //Initialization Settings for iOS
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotifications(
      String? title, String? body, dynamic payload) async {
        AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'hing',
    'Like notifications',
    'Display notifications when a comment, recipe, reply is liked.',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
    styleInformation: BigTextStyleInformation(body!)
  );

  IOSNotificationDetails _iosNotificationDetails = IOSNotificationDetails(
      presentAlert: false,
      presentBadge: true,
      presentSound: true,
      badgeNumber: null,
      attachments: null,
      subtitle: null,
      threadIdentifier: 'Hing');

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: _androidNotificationDetails, iOS: _iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      title,
      body,
      platformChannelSpecifics,
      payload: '',
    );
  }
}
