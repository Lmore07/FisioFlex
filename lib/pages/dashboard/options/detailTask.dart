import 'package:fisioflex/pages/classes/alerts.dart';
import 'package:fisioflex/pages/classes/textToSpeech.dart';
import 'package:fisioflex/pages/designs/appBar.dart';
import 'package:fisioflex/pages/designs/buttons.dart';
import 'package:fisioflex/pages/designs/txtParraph.dart';
import 'package:fisioflex/pages/classes/videoPlayer.dart';
import 'package:fisioflex/pages/services/taskService.dart';
import 'package:flutter/material.dart';

//Variables globales
late int idTask;
late String title;
late int idAssigment;
TextToSpeech textToSpeech = TextToSpeech();
late VideoPlayerScreen _videoPlayerScreen;

class detailTask extends StatefulWidget {
  const detailTask({super.key});

  @override
  State<detailTask> createState() => _detailTaskState();
}

class _detailTaskState extends State<detailTask> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    idAssigment = arguments['idAssigment'];
    idTask = arguments['idTask'];
    title = arguments['title'];
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerScreen =
        VideoPlayerScreen(url: 'https://www.youtube.com/watch?v=1Nr_tqkMsJs');
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
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 112),
                child: Wrap(children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                ]),
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
            _videoPlayerScreen,
            SizedBox(height: 20),
            buttonFinish(
                label: 'Finalizar tarea',
                onPressed: () {
                  completeTask(context);
                }),
          ],
        ));
  }
}

void completeTask(BuildContext context) {
  completeTaskService(idAssigment).then((value) =>
      {if (value) completedTrue(context) else completedFalse(context)});
}

void completedTrue(BuildContext context) async {
  CustomEasyLoading.instance.showSuccess('Se ha completado su tarea');
  // Esperar un segundo
  await Future.delayed(Duration(milliseconds: 1500));
  _videoPlayerScreen.dispose();
  // Redireccionar a la ruta 'tasks-list'
  Navigator.pushNamed(context, 'tasks-list');
}

void completedFalse(BuildContext context) {
  CustomEasyLoading.instance.showError('No se ha completado su tarea');
}
