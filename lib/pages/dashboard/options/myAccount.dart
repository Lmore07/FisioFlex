import 'package:fisioflex/pages/dashboard/options/detailTask.dart';
import 'package:fisioflex/pages/designs/appBar.dart';
import 'package:fisioflex/pages/designs/buttons.dart';
import 'package:fisioflex/pages/designs/inputs.dart';
import 'package:fisioflex/pages/interfaces/interfaces.dart';
import 'package:fisioflex/pages/services/myInfo.dart';
import 'package:flutter/material.dart';

//Variables Globales
MyInformation myInformation = MyInformation();

class myAccount extends StatefulWidget {
  const myAccount({super.key});

  @override
  State<myAccount> createState() => _myAccountState();
}

class _myAccountState extends State<myAccount> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(156, 211, 221, 1),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBarCustom(
                subTittle: 'Atrás',
                tittle: 'Mi perfil',
                icon: Icons.arrow_back_rounded,
                onPressed: () {
                  Navigator.pushNamed(context, 'dashboard');
                })),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: [
            SizedBox(height: 25),
            ImageProfile(),
            SizedBox(height: 25),
            inputProfile('Nombrees', 'Nombres', lines: 1),
            inputProfile('1234567890', 'Cédula', lines: 1),
            inputProfile('0994625454', 'Teléfono', lines: 1),
            inputProfile('asdasd', 'Descripción', lines: 5),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsetsDirectional.only(start: 20, end: 20),
              child: buttonVoice(
                onPressed: () {
                  textToSpeech.speak(
                      "Datos de tu perfil, Tus nombres ${myInformation.names}, Tu cédula ${myInformation.identification}, Tu numero de teléfono ${myInformation.phone}, una pequeña descripción de ti ${myInformation.description}");
                },
                label: 'Dictar por voz',
              ),
            ),
            SizedBox(height: 25),
          ],
        ))),
      ),
    );
  }

  Container inputProfile(String value, label, {int? lines}) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelInputs(label),
          SizedBox(height: 5),
          InputWidgetProfile(label: value, maxLines: lines),
        ],
      ),
    );
  }

  Text labelInputs(String label) {
    return Text(
      label,
      textAlign: TextAlign.end,
      style: TextStyle(
          fontSize: 18,
          fontFamily: 'Nunito',
          color: Color(0xFF2F2F2F),
          fontWeight: FontWeight.w400),
    );
  }
}

class ImageProfile extends StatelessWidget {
  const ImageProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 100, end: 100),
      child: Column(children: [
        if (myInformation.image != null) Image.network(''),
        if (myInformation.names == null)
          Image(
            image: AssetImage('assets/images/avatar_logo.png'),
            fit: BoxFit.cover,
          )
      ]),
    );
  }
}

Future<void> loadData() async {
  myInformation = await myInfoService();
}
