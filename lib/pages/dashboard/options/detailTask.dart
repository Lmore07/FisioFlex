import 'package:fisioflex/pages/classes/alerts.dart';
import 'package:fisioflex/pages/classes/textToSpeech.dart';
import 'package:fisioflex/pages/designs/appBar.dart';
import 'package:fisioflex/pages/designs/buttons.dart';
import 'package:fisioflex/pages/designs/txtParraph.dart';
import 'package:fisioflex/pages/classes/videoPlayer.dart';
import 'package:flutter/material.dart';

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
              onPressed: () {
                Navigator.pushNamed(context, 'tasks-list');
              },
              icon: Icons.arrow_back_rounded,
            )),
        body: SingleChildScrollView(
          child: detailTaskWidget(),
        ),
      ),
    );
  }
}

class detailTaskWidget extends StatelessWidget {
  const detailTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsetsDirectional.all(20),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Titulo de la tarea',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(height: 20),
            VideoPlayerScreen(
                videoUrl: 'https://www.youtube.com/watch?v=v_zZmsFZDaM'),
            SizedBox(height: 20),
            buttonFinish(
                label: 'Finalizar tarea',
                onPressed: () {
                  CustomEasyLoading.instance
                      .showSuccess('Se ha completado su tarea');
                }),
          ],
        ));
  }
}
