import 'package:fisioflex/pages/classes/textToSpeech.dart';
import 'package:fisioflex/pages/designs/appBar.dart';
import 'package:fisioflex/pages/designs/buttons.dart';
import 'package:fisioflex/pages/designs/txtParraph.dart';
import 'package:fisioflex/pages/designs/txtTitle.dart';
import 'package:fisioflex/pages/designs/videoPlayer.dart';
import 'package:fisioflex/pages/security/recoveryPassword.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

TextToSpeech textToSpeech = TextToSpeech();

class detailTask extends StatefulWidget {
  const detailTask({super.key});

  @override
  State<detailTask> createState() => _detailTaskState();
}

class _detailTaskState extends State<detailTask> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(156, 211, 221, 1),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBarCustom(
              tittle: 'Detalle de tarea',
              subTittle: 'Atrás',
              icon: Icons.arrow_back_rounded,
            )),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsetsDirectional.all(20),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Titulo de la tarea',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        buttonVoiceIcon(onPressed: () {
                          textToSpeech.speak('Probando detalle');
                        }),
                      ]),
                  txtParraph(label: 'label'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Video explicativo',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  VideoPlayerScreen(
                      videoUrl: 'https://www.youtube.com/watch?v=5sPQiHIA8Y8'),
                  SizedBox(height: 20),
                  buttonFinish(label: 'Finalizar tarea', onPressed: () {}),
                ],
              )),
        ),
      ),
    );
  }
}
