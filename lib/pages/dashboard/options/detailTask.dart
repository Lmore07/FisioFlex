import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/messages.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/classes/textToSpeech.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/buttons.dart';
import 'package:TeraFlex/pages/designs/txtParraph.dart';
import 'package:TeraFlex/pages/classes/videoPlayer.dart';
import 'package:TeraFlex/pages/interfaces/assignmentInterface.dart';
import 'package:TeraFlex/pages/interfaces/userInterface.dart';
import 'package:TeraFlex/pages/services/assignmentService.dart';
import 'package:TeraFlex/pages/services/taskService.dart';
import 'package:flutter/material.dart';

//Variables globales
late int idAssigment;
late List<String> videos = [];
UserData? myInformation =
    UserData(id: 1, firstName: "", lastName: "", docNumber: "");
TextToSpeech textToSpeech = TextToSpeech();
late VideoPlayerScreen _videoPlayerScreen;

class detailTask extends StatefulWidget {
  const detailTask({super.key});

  @override
  State<detailTask> createState() => _detailTaskState();
}

class _detailTaskState extends State<detailTask> {
  @override
  void initState() {
    // TODO: implement initState
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
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    idAssigment = arguments['idAssigment'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBarCustom(
              tittle: 'Detalle de tarea',
              subTittle: 'Atrás',
              onPressed: () {
                textToSpeech.stop();
                _videoPlayerScreen.dispose();
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_rounded,
            )),
        body: const SingleChildScrollView(
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
        padding: const EdgeInsetsDirectional.all(20),
        child: FutureBuilder(
            future: loadDataTask(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width - 112),
                              child: Wrap(children: [
                                Text(
                                  snapshot.data!.data!.title,
                                  style: textStyleTittle,
                                ),
                              ]),
                            ),
                            buttonVoiceIcon(onPressed: () {
                              textToSpeech.speak(getMessageVoice(
                                  myInformation?.firstName,
                                  snapshot.data!.data!.title,
                                  snapshot.data!.data!.description!,
                                  snapshot.data!.data!.estimatedTime));
                            }),
                          ]),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: txtParraph(
                            label: snapshot.data!.data!.description!),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Video explicativo',
                            style: textStyleTittle,
                          ),
                        ],
                      ),
                      spaced(20, 0),
                      _videoPlayerScreen = VideoPlayerScreen(
                          filesMultimedia: snapshot.data!.data!.files),
                      spaced(20, 0),
                      if (!snapshot.data!.data!.isCompleted)
                        buttonFinish(
                            label: 'Finalizar tarea',
                            onPressed: () {
                              completeTask(context);
                            }),
                    ]);
              } else if (snapshot.hasError) {
                return Text("");
              } else {
                return Text("");
              }
            }));
  }
}

void completeTask(BuildContext context) {
  CustomEasyLoading.instance.showLoading('Completando tarea...');
  completeTaskService(idAssigment).then((value) =>
      {if (value) completedTrue(context) else completedFalse(context)});
}

void completedTrue(BuildContext context) async {
  CustomEasyLoading.instance.dismiss();
  _videoPlayerScreen.dispose();
  CustomEasyLoading.instance.showSuccess('Se ha completado su tarea');
  await Future.delayed(Duration(milliseconds: 1500));
  textToSpeech.stop();
  Navigator.pop(context, true);
}

void completedFalse(BuildContext context) {
  CustomEasyLoading.instance.dismiss();
  CustomEasyLoading.instance.showError('No se ha completado su tarea');
}

Future<AssginmentResponse> loadDataTask() async {
  return await assignmentDetailService(idAssigment);
}
