import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/dashboard/options/detailTask.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/buttons.dart';
import 'package:TeraFlex/pages/designs/inputs.dart';
import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:TeraFlex/pages/services/myInfoService.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

//Variables Globales
UserData? myInformation =
    UserData(id: 1, firstName: "", lastName: "", docNumber: "");

class myAccount extends StatefulWidget {
  const myAccount({super.key});

  @override
  State<myAccount> createState() => _myAccountState();
}

class _myAccountState extends State<myAccount> {
  @override
  void initState() {
    super.initState();
    getUserInformation('userInformation').then((value) {
      myInformation = value;
      setState(() {
        myInformation = value;
      });
    });
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
            inputProfile(
                "${myInformation?.firstName} ${myInformation?.lastName}",
                'Nombres',
                lines: 1),
            inputProfile(myInformation?.docNumber, 'Cédula', lines: 1),
            if (myInformation?.phone != null)
              inputProfile(myInformation?.phone, 'Teléfono', lines: 1),
            if (myInformation?.description != null)
              inputProfile(myInformation?.description, 'Descripción', lines: 5),
            SizedBox(height: 10),
            actionsButtons(),
            SizedBox(height: 25),
          ],
        ))),
      ),
    );
  }

  Container inputProfile(String? value, label, {int? lines}) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelInputs(label),
          SizedBox(height: 5),
          InputWidgetProfile(label: value!, maxLines: lines),
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

class actionsButtons extends StatelessWidget {
  const actionsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Column(
        children: [
          buttonTest(
            onPressed: () {
              textToSpeech.speak(
                  'Hola, tu nombre es: ${myInformation?.firstName} ${myInformation?.lastName}, tu número de cédula es: ${myInformation?.docNumber}');
            },
          ),
          SizedBox(height: 15),
          buttonLogOut(
            onPressed: () {
              clear();
              Navigator.popUntil(context, ModalRoute.withName('login'));
            },
          )
        ],
      ),
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
        Image(
          image: AssetImage('assets/images/avatar_logo.png'),
          fit: BoxFit.cover,
        )
      ]),
    );
  }
}
