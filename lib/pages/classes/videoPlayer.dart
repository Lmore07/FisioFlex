import 'dart:io';

import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/services/multimediaService.dart';
import 'package:webview_flutter_platform_interface/src/platform_navigation_delegate.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

ChewieController? _chewieController;
VideoPlayerController? _videoPlayerController;
YoutubePlayerController? _youtubePlayerController;
late PageController _pageController;
final videoExtensions = [
  'mp4',
  'avi',
  'mov',
  'wmv',
  'mkv',
  'flv',
  'webm',
  'm4v',
  '3gp',
  'mpeg'
];
int indexVideo = 0;
File videoFile = File('');

class VideoPlayerScreen extends StatefulWidget {
  late List<dynamic> url;
  late List<int> idVideos;
  VideoPlayerScreen({super.key});

  void dispose() {
    if (_chewieController != null) {
      _chewieController?.dispose();
      videoFile = File('');
    }
    if (_videoPlayerController != null) {
      _videoPlayerController?.dispose();
      videoFile = File('');
    }
    if (_youtubePlayerController != null) {
      _youtubePlayerController?.pause();
      _youtubePlayerController?.dispose();
    }
    indexVideo = 0;
    url.clear();
    idVideos.clear();
  }

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  get idVideos => null;

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

  dynamic downloadFile() {
    downloadFileService(widget.idVideos[indexVideo]).then((value) {
      setState(() {
        videoFile = value;
        _videoPlayerController = VideoPlayerController.file(videoFile);
        _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            autoPlay: true,
            looping: true);
        CustomEasyLoading.instance.dismiss();
      });
      ;
    });
  }

  @override
  void dispose() {
    // Libera los recursos de los controladores de video al salir del componente
    if (_chewieController != null) {
      _chewieController?.dispose();
      videoFile = File('');
    }
    if (_videoPlayerController != null) {
      _videoPlayerController?.dispose();
      videoFile = File('');
    }
    if (_youtubePlayerController != null) {
      _youtubePlayerController?.pause();
      _youtubePlayerController?.dispose();
    }
    indexVideo = 0;
    widget.url.clear();
    idVideos.clear();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListString('videoUrls').then((value) => {
          CustomEasyLoading.instance.dismiss(),
          setState(() {
            widget.url = value;
          }),
          getListInt("idVideos").then((ids) => {widget.idVideos = ids}),
          if (isYoutubeLink(widget.url[indexVideo]))
            {
              if (Platform.isAndroid || Platform.isIOS)
                {
                  _youtubePlayerController = YoutubePlayerController(
                      initialVideoId:
                          YoutubePlayer.convertUrlToId(widget.url[indexVideo])!,
                      flags: YoutubePlayerFlags(
                        autoPlay: true,
                        controlsVisibleAtStart: true,
                        mute: false,
                      )),
                }
            }
          // Configuración para videos no relacionados con YouTube
          else if (isNaturalVideo(widget.url[indexVideo]))
            {
              downloadFile(),
              _videoPlayerController = VideoPlayerController.file(videoFile),
              _chewieController = ChewieController(
                  videoPlayerController: _videoPlayerController!,
                  autoPlay: true,
                  looping: true),
              CustomEasyLoading.instance.dismiss(),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Center(
              child: Column(
        children: [
          if ((Platform.isAndroid || Platform.isIOS) &&
              isYoutubeLink(widget.url[indexVideo]))
            showYoutubeVideo()
          else if ((Platform.isAndroid || Platform.isIOS) &&
              !isNaturalVideo(widget.url[indexVideo]) &&
              !isYoutubeLink(widget.url[indexVideo]))
            showImage()
          else if ((Platform.isAndroid || Platform.isIOS) &&
              isNaturalVideo(widget.url[indexVideo]))
            if (_chewieController != null)
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
          if (widget.url.length > 1) showButtons()
        ],
      ))),
    );
  }

  Container showButtons() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (indexVideo > 0)
            ElevatedButton(
                child: Container(
                  padding: EdgeInsetsDirectional.all(2),
                  child: Text("Video Anterior",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                onPressed: () {
                  setState(() {
                    previousButton();
                  });
                }),
          SizedBox(width: 5),
          if (indexVideo < widget.url.length - 1)
            ElevatedButton(
                child: Container(
                  child: Text("Video Siguiente",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                onPressed: () {
                  setState(() {
                    nextButton();
                  });
                })
        ],
      ),
    );
  }

  void nextButton() {
    CustomEasyLoading.instance.showLoading('Cargando video...');
    indexVideo++;
    if (isYoutubeLink(widget.url[indexVideo])) {
      if (_youtubePlayerController == null) {
        _youtubePlayerController = YoutubePlayerController(
          flags: YoutubePlayerFlags(
            autoPlay: true,
            controlsVisibleAtStart: true,
            mute: false,
          ),
          initialVideoId: YoutubePlayer.convertUrlToId(widget.url[indexVideo])!,
        );
      }
      _youtubePlayerController!
          .load(YoutubePlayer.convertUrlToId(widget.url[indexVideo])!);
      CustomEasyLoading.instance.dismiss();
    } else if (isNaturalVideo(widget.url[indexVideo])) {
      downloadFile();
    } else {
      videoFile = File('');
    }
    CustomEasyLoading.instance.dismiss();
  }

  void previousButton() {
    CustomEasyLoading.instance.showLoading('Cargando video...');
    indexVideo--;
    if (isYoutubeLink(widget.url[indexVideo])) {
      if (_youtubePlayerController == null) {
        _youtubePlayerController = YoutubePlayerController(
          flags: YoutubePlayerFlags(
            autoPlay: true,
            controlsVisibleAtStart: true,
            mute: false,
          ),
          initialVideoId: YoutubePlayer.convertUrlToId(widget.url[indexVideo])!,
        );
      }
      _youtubePlayerController!
          .load(YoutubePlayer.convertUrlToId(widget.url[indexVideo])!);
    } else if (isNaturalVideo(widget.url[indexVideo])) {
      downloadFile();
    } else {
      videoFile = File('');
    }
    CustomEasyLoading.instance.dismiss();
  }

  Column showImage() {
    if (videoFile.path == "") {
      CustomEasyLoading.instance.showLoading('Cargando imagen...');
      downloadFile();
    }
    return Column(
      children: [
        if (videoFile.path != "") Image.file(videoFile),
      ],
    );
  }
}

class showYoutubeVideo extends StatelessWidget {
  const showYoutubeVideo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubePlayerController!,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return player;
      },
    );
  }
}
