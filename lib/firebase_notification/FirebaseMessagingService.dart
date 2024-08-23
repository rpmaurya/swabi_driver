import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  BuildContext? context;

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> setupFirebase(BuildContext contextRef,
      {Function(bool)? notificationCallback}) async {
    context = context;
    _getDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message data notification body: ${message.notification?.body}');
      if (notificationCallback != null) {
        notificationCallback(true);
      }
      showNotificationWithDefaultSound("${message.notification?.title}",
          "${message.notification?.body}", message);

      print(
          'Message also contained a notification: ${message.notification?.toMap()}');
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print({"objectobjectobjectobject": message.data});

      Map<String, dynamic> mapData = {
        ...message.data,
      };

      dynamic senderGData = json.decode(mapData['sender']);
      print({"mapData['sender']['_id']": senderGData["_id"]});

      // Get.to(ChattingScreen(
      //   targetUserId: senderGData['_id'], //"64099587f8db67c379fce05b",
      //   targetUserName: senderGData['firstname'],
      //   authToken: "",
      //   image: senderGData['image'][0]["image"],
      // ));
      // }

      print('A new onMessageOpenedApp event was published!');
    });
  }

  Future<String> _getDeviceToken() async {
    String? _deviceToken;
    // if (Platform.operatingSystem == "ios") {
    //   _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    // } else {
    //   _deviceToken = await FirebaseMessaging.instance.getToken();
    // }
    _deviceToken = await FirebaseMessaging.instance.getToken();

    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken == "" ? "simulatorlogin" : _deviceToken ?? "dummyToken";
  }

  Future<void> setupLocalNotification() async {
    print("LocalNotification initi");
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new DarwinInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin?.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (msg) {
      Fluttertoast.showToast(msg: "Clicked");

      print({"msg": msg, "notificationId": msg.payload});
      if (msg.payload == null) {
        Fluttertoast.showToast(msg: "Somthing went wrong");
        return;
      }
      RemoteMessage remoteMessage =
          RemoteMessage.fromMap(json.decode(msg.payload!));

      Map<String, dynamic> mapData = {
        ...remoteMessage.data,
      };

      dynamic senderGData = json.decode(mapData['sender']);
      print({"mapData['sender']['_id']": senderGData["_id"]});

      // Get.to(ChattingScreen(
      //   targetUserId: senderGData["_id"], //"64099587f8db67c379fce05b",
      //   targetUserName: senderGData['firstname'],
      //   authToken: "",
      //   image: senderGData['image'][0]["image"],
      // ));
      // Navigator.of(context).pushNamed(NotificationDetailScreen.id,
      //     arguments: {"data": null, "notificationID": notificationId});
    }).then((value) {
      print({"initilize": value});
    });
  }

  Future showNotificationWithDefaultSound(
      String title, String body, RemoteMessage remoteMessage) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    // var iOSPlatformChannelSpecifics = new IOSNotificationDetail;
    var iOSPlatformChannelSpecifics =
        new DarwinNotificationDetails(presentAlert: true);
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
      0,
      '$title',
      '$body',
      platformChannelSpecifics,
      payload: json.encode(remoteMessage.toMap()),
    );
  }
}
