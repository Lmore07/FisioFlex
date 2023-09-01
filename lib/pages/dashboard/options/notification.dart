import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/firebaseApi.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/cardButton.dart';
import 'package:TeraFlex/pages/interfaces/notificationInterface.dart';
import 'package:TeraFlex/pages/services/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:TeraFlex/pages/classes/textToSpeech.dart';

List<NotificationI> notificationList = [];
TextToSpeech textToSpeech = TextToSpeech();

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  void initState() {
    super.initState();
    notificationList.clear();
    verificationDevice().then((value) {
      if (value.statusCode == 404) {
        requestPermission();
        saveDevice();
        configureFirebaseMessaging();
      }
      getNotifications();
    });
  }

  void getNotifications() {
    CustomEasyLoading.instance.showLoading('Cargando notificaciones...');
    notificationList.clear();
    getAllNotifications().then((value) {
      CustomEasyLoading.instance.dismiss();
      if (value.data != null && value.data!.isNotEmpty) {
        setState(() {
          notificationList = value.data!;
        });
      }
      if (value.data!.isEmpty) {
        CustomEasyLoading.instance
            .showMessage("No tiene notificaciones pendientes");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        CustomEasyLoading.instance.dismiss();
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBarCustom(
              tittle: 'Notificaciones',
              subTittle: 'Atrás',
              onPressed: () {
                textToSpeech.stop();
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_rounded,
            )),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsetsDirectional.all(20),
              child: Column(
                children: showNotifications(context),
              )),
        ),
      ),
    ));
  }

  List<Widget> showNotifications(BuildContext context) {
    return [
      for (var notification in notificationList)
        cardTask(context, notification),
    ];
  }

  Padding cardTask(BuildContext context, NotificationI notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: cardNotification(
          tittle: notification.title,
          subtitle: notification.body,
          onPressed: () {
            CustomEasyLoading.instance.showLoading('Eliminando Notificación');
            deleteNotification(notification.id).then((value) {
              if (value.statusCode == 200) {
                CustomEasyLoading.instance.dismiss();
                CustomEasyLoading.instance
                    .showSuccess("Notificación eliminada");
                notificationList.clear();
                getNotifications();
              } else {
                CustomEasyLoading.instance.dismiss();
                CustomEasyLoading.instance
                    .showError("Error al eliminar la notificación");
              }
            });
          }),
    );
  }
}
