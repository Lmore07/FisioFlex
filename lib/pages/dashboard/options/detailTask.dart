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
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

//Variables globales
late int idAssigment;
late List<String> videos = [];
UserData? myInformation =
    UserData(id: 1, firstName: "", lastName: "", docNumber: "");
late VideoPlayerScreen _videoPlayerScreen;

class detailTask extends StatefulWidget {
  const detailTask({super.key});

  static TextToSpeech textToSpeech = TextToSpeech();

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
                detailTask.textToSpeech.stop();
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
        padding: const EdgeInsetsDirectional.all(15),
        margin:
            EdgeInsetsDirectional.only(top: 15, start: 15, end: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
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
                                      MediaQuery.of(context).size.width - 140),
                              child: Wrap(children: [
                                Text(
                                  snapshot.data!.data!.title,
                                  style: textStyleTittle,
                                ),
                              ]),
                            ),
                            buttonVoiceIcon(onPressed: () async {
                              var talk = true;
                              for (var controller
                                  in VideoPlayerScreen.youtubeControllers) {
                                if (await controller.playerState ==
                                        PlayerState.playing ||
                                    await controller.playerState ==
                                        PlayerState.buffering) {
                                  talk = false;
                                  break;
                                }
                              }
                              for (var controller
                                  in VideoPlayerScreen.podPlayerControllers) {
                                if (controller.isVideoPlaying ||
                                    controller.isVideoBuffering) {
                                  talk = false;
                                  break;
                                }
                              }
                              if (talk) {
                                detailTask.textToSpeech.speak(getMessageVoice(
                                    myInformation?.firstName,
                                    snapshot.data!.data!.title,
                                    snapshot.data!.data!.description!,
                                    snapshot.data!.data!.estimatedTime));
                              }
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
  detailTask.textToSpeech.stop();
  Navigator.pop(context, true);
}

void completedFalse(BuildContext context) {
  CustomEasyLoading.instance.dismiss();
  CustomEasyLoading.instance.showError('No se ha completado su tarea');
}

Future<AssginmentResponse> loadDataTask() async {
  return await assignmentDetailService(idAssigment);
}
