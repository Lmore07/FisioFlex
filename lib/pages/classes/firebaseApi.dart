import 'dart:convert';
import 'dart:io';

import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info/device_info.dart';

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

void configureFirebaseMessaging() {
  print("Entrando a los escuchas");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Notificacion: ${message.notification?.body}');
    // Aquí manejas la notificación cuando la aplicación está en primer plano
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Aquí manejas la notificación cuando la aplicación se abre desde la notificación
    print('Notificación abierta: ${message.notification?.body}');
  });

  // Configura el comportamiento cuando la app se abre desde una notificación (app en segundo plano o cerrada)
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
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

void getToken() async {
  await FirebaseMessaging.instance.getToken().then((value) {
    print("Token: $value");
    saveString('tokenNotification', value!);
  });
}
