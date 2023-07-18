import 'dart:io';
import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/interfaces/assignmentInterface.dart';
import 'package:TeraFlex/pages/services/multimediaService.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pod_player/pod_player.dart';

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
    return SafeArea(
      child: Center(
          child: Column(
        children: [
          FutureBuilder(
              future: loadMultimedia(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CarouselSlider(
                      carouselController: _controller,
                      items: snapshot.data,
                      options: CarouselOptions(
                          autoPlay: false,
                          height: 300,
                          enlargeCenterPage: true,
                          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                          enlargeFactor: 0.5));
                } else if (snapshot.hasError) {
                  return Text("");
                } else {
                  return CircularProgressIndicator();
                }
              }),
          spaced(25, 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: ElevatedButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: () => _controller.previousPage())),
              ...Iterable<int>.generate(widget.filesMultimedia.length)
                  .map((e) => Flexible(
                          child: ElevatedButton(
                        onPressed: () => _controller.animateToPage(e),
                        child: Text((e + 1).toString()),
                      ))),
              Flexible(
                  child: ElevatedButton(
                      child: Icon(Icons.arrow_forward),
                      onPressed: () => _controller.nextPage())),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: widget.url.asMap().entries.map((entry) {
          //     return GestureDetector(
          //       onTap: () => _controller.animateToPage(entry.key),
          //       child: Container(
          //         width: 12.0,
          //         height: 12.0,
          //         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          //         decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: (Theme.of(context).brightness == Brightness.dark
          //                     ? Colors.white
          //                     : Colors.black)
          //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          //       ),
          //     );
          //   }).toList(),
        ],
      )),
    );
  }

  Future<List<Widget>> loadMultimedia() async {
    List<Widget> carouselItems = [];
    for (var i = 0; i < widget.filesMultimedia.length; i++) {
      if (widget.filesMultimedia[i].type == "online") {
        var podPlayerYoutubeController = PodPlayerController(
            playVideoFrom: PlayVideoFrom.youtube(
              widget.filesMultimedia[i].url,
            ),
            podPlayerConfig: PodPlayerConfig(autoPlay: false))
          ..initialise();
        podPlayerControllers.add(podPlayerYoutubeController);
        carouselItems
            .add(PodVideoPlayer(controller: podPlayerYoutubeController));
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
