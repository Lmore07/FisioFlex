import 'package:TeraFlex/pages/classes/firebaseApi.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/cardButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//global variables
String username = "";

class dashboardClient extends StatefulWidget {
  const dashboardClient({super.key});

  @override
  State<dashboardClient> createState() => _dashboardClientState();
}

class _dashboardClientState extends State<dashboardClient> {
  @override
  void initState() {
    username = "";
    // TODO: implement initState
    super.initState();
    requestPermission();
    getUserInformation('userInformation').then(
      (value) {
        var firstName = value!.firstName.split(' ');
        username = firstName[0];
        setState(() {
          username = firstName[0];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseContext.context = context;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
            child: AppBarCustom(
              username: username,
              subTittle: 'TeraFlex',
              tittle: 'Hola,',
            ),
            preferredSize: Size.fromHeight(100),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cardButtonWidget(
                          icon: Icons.format_list_bulleted_rounded,
                          tittle: 'Tareas',
                          onPressed: () {
                            redirectToTasksList(context);
                          }),
                      spaced(25, 0),
                      cardButtonWidget(
                          icon: Icons.notifications_sharp,
                          tittle: 'Notificaciones',
                          onPressed: () {
                            redirectToNotification(context);
                          }),
                      spaced(25, 0),
                      cardButtonWidget(
                          icon: Icons.person_3_sharp,
                          tittle: 'Mi perfil',
                          onPressed: () {
                            redirectToAccount(context);
                          }),
                      spaced(25, 0),
                      cardButtonWidget(
                          icon: Icons.help_sharp,
                          tittle: 'Ayuda',
                          onPressed: () {
                            redirectToHelp(context);
                          }),
                      spaced(25, 0),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void redirectToTasksList(BuildContext context) {
  Navigator.pushNamed(context, 'tasks-list');
}

void redirectToAccount(BuildContext context) {
  Navigator.pushNamed(context, 'my-account');
}

void redirectToHelp(BuildContext context) {
  Navigator.pushNamed(context, 'help');
}

void redirectToNotification(BuildContext context) {
  Navigator.pushNamed(context, 'notification');
}
