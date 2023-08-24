import 'dart:io';
import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/interfaces/assignmentInterface.dart';
import 'package:TeraFlex/pages/services/multimediaService.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

List<PodPlayerController> podPlayerControllers = [];
final CarouselController _controller = CarouselController();
File videoFile = File('');

// ignore: must_be_immutable
class VideoPlayerScreen extends StatefulWidget {
  final List<AssignmentFile> filesMultimedia;
  VideoPlayerScreen({super.key, required this.filesMultimedia});

  void dispose() {
    for (var controller in podPlayerControllers) {
      controller.dispose();
    }
    filesMultimedia.clear();
  }

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final PodPlayerController? podPlayerYoutubeController;
  late final PodPlayerController? podPlayerFileController;

  Future<File> downloadFile(int index) async {
    return await downloadFileService(widget.filesMultimedia[index].id);
  }

  @override
  void dispose() {
    // Libera los recursos de los controladores de video al salir del componente
    for (var controller in podPlayerControllers) {
      controller.dispose();
    }
    widget.filesMultimedia.clear();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return SafeArea(
      child: Center(
          child: Column(
        children: [
          FutureBuilder(
              future: loadMultimedia(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data![index];
                } else if (snapshot.hasError) {
                  return Text(
                    "",
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          spaced(25, 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (index > 0)
                Flexible(
                    child: ElevatedButton(
                        child: Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            index -= 1;
                          });
                        })),
              if (index < widget.filesMultimedia.length - 1)
                Flexible(
                    child: ElevatedButton(
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          setState(() {
                            index += 1;
                          });
                        })),
            ],
          ),
        ],
      )),
    );
  }

  Future<List<Widget>> loadMultimedia() async {
    List<Widget> carouselItems = [];
    for (var i = 0; i < widget.filesMultimedia.length; i++) {
      if (widget.filesMultimedia[i].type == "online") {
        var youtubePlayerController = YoutubePlayerController(
            params: YoutubePlayerParams(
                enableJavaScript: false,
                showVideoAnnotations: false,
                enableKeyboard: false,
                showFullscreenButton: false,
                showControls: true,
                mute: false));
        youtubePlayerController.loadVideoById(
            videoId: YoutubePlayerController.convertUrlToId(
                widget.filesMultimedia[i].url)!);
        carouselItems.add(YoutubePlayerScaffold(
          builder: (context, player) {
            return player;
          },
          controller: youtubePlayerController,
        ));
      } else if (videoExtensions.contains(widget.filesMultimedia[i].type)) {
        File video = await downloadFile(i);
        var podPlayerFileController = PodPlayerController(
            playVideoFrom: PlayVideoFrom.file(
              video,
            ),
            podPlayerConfig: PodPlayerConfig(autoPlay: false))
          ..initialise();
        podPlayerControllers.add(podPlayerFileController);
        carouselItems.add(PodVideoPlayer(controller: podPlayerFileController));
      } else {
        File imagen = await downloadFile(i);
        carouselItems.add(Image.file(imagen));
      }
    }
    CustomEasyLoading.instance.dismiss();
    return carouselItems;
  }
}
