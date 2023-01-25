import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:learning_flutter/services/LocalNotificationService.dart';

import '../services/NotificationService.dart';

class LocalNotification extends StatefulWidget {
  const LocalNotification({Key? key}) : super(key: key);

  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  late final LocalNotificationService services;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final NotificationService _notificationService = NotificationService();



  @override
  initState(){
    services = LocalNotificationService();
    services.intialize();

    _notificationService.initializePlatformNotifications();
   super.initState();
  }

  void listenToNotificationStream() =>
      _notificationService.behaviorSubject.listen((payload) {
        print("Click on notification");
      });



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: ()  async {
            // print("Hi you clicked me");
            // await services.showNotification(id: 0, title: "Hi iam notification", body: "This Is test local notification");
            await _notificationService.showLocalNotification(
                id: 0,
                title: "Drink Water",
                body: "Time to drink some water!",
                payload: "You just took water! Huurray!");
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: const Text(
                "Normal Notification",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async{
            await _notificationService.showScheduledLocalNotification(
                id: 1,
                title: "Drink Water",
                body: "Time to drink some water!",
                payload: "You just took water! Huurray!",
                seconds: 2);
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: const Text(
                "scheduled Notification",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: const Text(
              "Remove Notification",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ))
      ],
    ));
  }
}

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  Future<void> initalize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@drawable/launch_background");

     IOSInitializationSettings iosInitializationSettings = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

     final InitializationSettings settings = InitializationSettings(
       android: androidInitializationSettings,
       iOS: iosInitializationSettings
     );

     await _notification.initialize(settings);
   }

  static Future _notificationDetail() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: "channel description",
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notification.show(id, title, body, await _notificationDetail(),
          payload: payload);

  void _onDidReceiveLocalNotification(int id, String title, String body, String payload) {
   print("id  $id");
  }
}


