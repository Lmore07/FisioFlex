import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:flutter/material.dart';

class helpMenu extends StatefulWidget {
  const helpMenu({super.key});

  @override
  State<helpMenu> createState() => _helpMenuState();
}

class _helpMenuState extends State<helpMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(156, 211, 221, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarCustom(
            tittle: 'Ayuda',
            subTittle: 'Atrás',
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              Navigator.pushNamed(context, 'dashboard');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                textTitleCards('¿Cómo completar tareas?'),
                SizedBox(height: 8),
                Container(
                    constraints: BoxConstraints(maxHeight: 150),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 25),
                    child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding textTitleCards(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(label,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Color(0xFF2F2F2F),
              fontSize: 22,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800)),
    );
  }
}
