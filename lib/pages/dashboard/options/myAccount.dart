import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/classes/textToSpeech.dart';
import 'package:TeraFlex/pages/dashboard/options/detailTask.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/buttons.dart';
import 'package:TeraFlex/pages/designs/inputs.dart';
import 'package:TeraFlex/pages/interfaces/userInterface.dart';
import 'package:TeraFlex/pages/services/notificationService.dart';
import 'package:flutter/material.dart';

//Variables Globales
UserData? myInformation =
    UserData(id: 1, firstName: "", lastName: "", docNumber: "");
TextToSpeech textToSpeech = TextToSpeech();

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
      child: WillPopScope(
        onWillPop: () async {
          textToSpeech.stop();
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBarCustom(
                  subTittle: 'Atrás',
                  tittle: 'Mi perfil',
                  icon: Icons.arrow_back_rounded,
                  onPressed: () {
                    textToSpeech.stop();
                    Navigator.pop(context);
                  })),
          body: SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsetsDirectional.all(15),
                  child: Column(
                    children: [
                      spaced(25, 0),
                      ImageProfile(),
                      spaced(25, 0),
                      inputProfile(
                          "${myInformation?.firstName} ${myInformation?.lastName}",
                          'Nombres',
                          lines: 1),
                      inputProfile(myInformation?.docNumber, 'Cédula',
                          lines: 1),
                      if (myInformation?.phone != null)
                        inputProfile(myInformation?.phone, 'Teléfono',
                            lines: 1),
                      if (myInformation?.description != null)
                        inputProfile(myInformation?.description, 'Descripción',
                            lines: 5),
                      spaced(25, 0),
                      actionsButtons(),
                      spaced(25, 0)
                    ],
                  ))),
        ),
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
          spaced(5, 0),
          InputWidgetProfile(label: value!, maxLines: lines),
        ],
      ),
    );
  }

  Text labelInputs(String label) {
    return Text(label, textAlign: TextAlign.end, style: textStyleLabels);
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
                  'Hola, tu nombre es: ${myInformation?.firstName} ${myInformation?.lastName}, tu número de cédula es: ${myInformation?.docNumber}, tu número de teléfono es: ${myInformation?.phone ?? 'vacia por ahora'} y tu descripción es: ${myInformation?.description ?? 'vacia por ahora'}');
            },
          ),
          spaced(15, 0),
          buttonLogOut(
            onPressed: () {
              updateDevice().then((value) {
                clear();
                Navigator.popUntil(context, ModalRoute.withName('dashboard'));
                Navigator.pushReplacementNamed(context, "login");
              });
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
      padding: EdgeInsetsDirectional.only(start: 120, end: 120),
      child: Column(children: [
        Image(
          image: AssetImage('assets/images/avatar_logo.png'),
          fit: BoxFit.cover,
        )
      ]),
    );
  }
}
