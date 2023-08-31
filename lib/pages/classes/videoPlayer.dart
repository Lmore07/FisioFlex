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
List<YoutubePlayerController> youtubeControllers = [];
final CarouselController _controller = CarouselController();
File videoFile = File('');
var index = 0;
List<Widget> loadedWidgets = []; // Almacena los widgets multimedia cargados

// ignore: must_be_immutable
class VideoPlayerScreen extends StatefulWidget {
  final List<AssignmentFile> filesMultimedia;
  VideoPlayerScreen({super.key, required this.filesMultimedia});

  void dispose() {
    for (var controller in podPlayerControllers) {
      controller.dispose();
    }
    for (var controller in youtubeControllers) {
      controller.stopVideo();
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
    for (var controller in youtubeControllers) {
      controller.stopVideo();
    }
    widget.filesMultimedia.clear();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAndStoreMultimedia();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Column(
        children: [
          if (loadedWidgets.isNotEmpty)
            IndexedStack(
              index: index,
              children: loadedWidgets,
            ),
          spaced(25, 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (index > 0)
                Flexible(
                    child: ElevatedButton(
                        child: Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            index -= 1;
                            for (var controller in youtubeControllers) {
                              controller.stopVideo();
                            }
                            for (var controller in podPlayerControllers) {
                              controller.dispose();
                            }
                          });
                        })),
              if (index < widget.filesMultimedia.length - 1)
                Flexible(
                    child: ElevatedButton(
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          setState(() {
                            index += 1;
                            for (var controller in youtubeControllers) {
                              controller.stopVideo();
                            }
                            for (var controller in podPlayerControllers) {
                              controller.dispose();
                            }
                          });
                        })),
            ],
          ),
        ],
      )),
    );
  }

  Future<void> loadAndStoreMultimedia() async {
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
        youtubeControllers.add(youtubePlayerController);
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

    setState(() {
      loadedWidgets = carouselItems;
    });

    CustomEasyLoading.instance.dismiss();
  }
}
