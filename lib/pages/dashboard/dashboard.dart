import 'package:fisioflex/pages/designs/appBar.dart';
import 'package:fisioflex/pages/designs/cardButton.dart';
import 'package:flutter/material.dart';

//global variables
String username = "";

class dashboardClient extends StatefulWidget {
  const dashboardClient({super.key});

  @override
  State<dashboardClient> createState() => _dashboardClientState();
}

class _dashboardClientState extends State<dashboardClient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(156, 211, 221, 1),
        appBar: PreferredSize(
          child: AppBarCustom(
            username: username,
            subTittle: 'FisioFlex',
            tittle: 'Hola,',
          ),
          preferredSize: Size.fromHeight(100),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              SizedBox(height: 25),
              cardButtonWidget(
                  icon: Icons.format_list_bulleted_rounded,
                  tittle: 'Tareas',
                  onPressed: () {
                    print('Tareas presionado');
                    redirectToTasksList(context);
                  }),
              SizedBox(height: 25),
              cardButtonWidget(
                  icon: Icons.notifications_sharp,
                  tittle: 'Notificaciones',
                  onPressed: () {
                    print('Notificaciones presionado');
                  }),
              SizedBox(height: 25),
              cardButtonWidget(
                  icon: Icons.person_3_sharp,
                  tittle: 'Mi perfil',
                  onPressed: () {
                    print('Mi perfil presionado');
                  }),
              SizedBox(height: 25),
              cardButtonWidget(
                  icon: Icons.help_sharp,
                  tittle: 'Ayuda',
                  onPressed: () {
                    print('Ayuda presionado');
                  }),
              SizedBox(height: 25),
            ]),
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.topCenter,
        child: Image.asset("assets/images/logo.png"));
  }
}

void redirectToTasksList(BuildContext context) {
  Navigator.pushNamed(context, 'tasks-list');
}
