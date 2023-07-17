import 'dart:io';
import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/services/multimediaService.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pod_player/pod_player.dart';

late PodPlayerController copyPodPlayerYoutubeController;
late PodPlayerController copyPodPlayerFileController;
final CarouselController _controller = CarouselController();

File videoFile = File('');

// ignore: must_be_immutable
class VideoPlayerScreen extends StatefulWidget {
  late List<dynamic> url;
  late List<int> idVideos;
  VideoPlayerScreen({super.key});

  void dispose() {
    copyPodPlayerYoutubeController.dispose();
    copyPodPlayerFileController.dispose();
    url.clear();
    idVideos.clear();
  }

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  get idVideos => null;
  late final PodPlayerController? podPlayerYoutubeController;
  late final PodPlayerController? podPlayerFileController;

  bool isYoutubeLink(String link) {
    return link.contains('youtube.com') || link.contains('youtu.be');
  }

  bool isNaturalVideo(String link) {
    final RegExp regExp = RegExp(r'\.(\w+)$');
    final match = regExp.firstMatch(link);
    if (match != null) {
      final extension = match.group(1)?.toLowerCase();
      if (videoExtensions.contains(extension)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<File> downloadFile(int index) async {
    return await downloadFileService(widget.idVideos[index]);
  }

  @override
  void dispose() {
    // Libera los recursos de los controladores de video al salir del componente
    copyPodPlayerYoutubeController.dispose();
    copyPodPlayerFileController.dispose();
    widget.url.clear();
    idVideos.clear();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListString('videoUrls')
        .then((value) => {
              CustomEasyLoading.instance.dismiss(),
              setState(() {
                widget.url = value;
              }),
              getListInt("idVideos").then((ids) => {widget.idVideos = ids}),
            })
        .catchError((error) {
      CustomEasyLoading.instance.dismiss();
      CustomEasyLoading.instance.showError(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ));
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
              ...Iterable<int>.generate(widget.url.length).map((e) => Flexible(
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
      ))),
    );
  }

  Future<List<Widget>> loadMultimedia() async {
    //CustomEasyLoading.instance.showLoading("Cargando recursos...");
    List<Widget> carouselItems = [];

    for (var i = 0; i < widget.url.length; i++) {
      if (isYoutubeLink(widget.url[i])) {
        podPlayerYoutubeController = PodPlayerController(
            playVideoFrom: PlayVideoFrom.youtube(
              widget.url[i],
            ),
            podPlayerConfig: PodPlayerConfig(autoPlay: false))
          ..initialise();
        copyPodPlayerYoutubeController = podPlayerYoutubeController!;
        carouselItems
            .add(PodVideoPlayer(controller: podPlayerYoutubeController!));
      } else if (isNaturalVideo(widget.url[i])) {
        File video = await downloadFile(i);
        podPlayerFileController = PodPlayerController(
            playVideoFrom: PlayVideoFrom.file(
              video,
            ),
            podPlayerConfig: PodPlayerConfig(autoPlay: false))
          ..initialise();
        copyPodPlayerFileController = podPlayerFileController!;
        carouselItems.add(PodVideoPlayer(controller: podPlayerFileController!));
      } else {
        File imagen = await downloadFile(i);
        carouselItems.add(Image.file(imagen));
      }
    }
    CustomEasyLoading.instance.dismiss();
    return carouselItems;
  }
}
