import 'dart:convert';
import 'dart:io';

import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseContext {
  static late BuildContext context;
}

final FlutterLocalNotificationsPlugin _localNotifications =
    FlutterLocalNotificationsPlugin();

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    configureFirebaseMessaging();
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
    configureFirebaseMessaging();
  } else {
    print('User declined or has not accepted permission');
  }
}

Future<void> configureFirebaseMessaging() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Notificacion: ${message.notification?.body}');
    final _androidChannel = const AndroidNotificationChannel("id", "name",
        description: "",
        importance: Importance.high,
        playSound: true,
        showBadge: true);
    final notification = message.notification;
    if (notification == null) return;
    initLocalNotifications();
    _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
            android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: "@mipmap/launcher_icon",
        )));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Aquí manejas la notificación cuando la aplicación se abre desde la notificación
    print('Notificación abierta: ${message.notification?.body}');
    Navigator.pushNamed(FirebaseContext.context, "dashboard");
  });

  // Configura el comportamiento cuando la app se abre desde una notificación (app en segundo plano o cerrada)
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
}

Future initLocalNotifications() async {
  const android = AndroidInitializationSettings("@mipmap/launcher_icon");
  const settings = InitializationSettings(android: android);
  await _localNotifications.initialize(settings);
}

Future<String> getDevideID() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
  print("onBackgroundMessage: $message");
}

Future<String?> getToken() async {
  return FirebaseMessaging.instance.getToken();
}
