import 'dart:io';

import 'package:webview_flutter_platform_interface/src/platform_navigation_delegate.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'
    as mobile_youtube;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart'
    as desktop_youtube;

ChewieController? _chewieController;
VideoPlayerController? _videoPlayerController;
mobile_youtube.YoutubePlayerController? _youtubePlayerController;
desktop_youtube.YoutubePlayerController? _desktopYoutubePlayerController;

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  const VideoPlayerScreen({super.key, required this.url});

  void dispose() {
    if (_chewieController != null) {
      _chewieController?.dispose();
    }
    if (_videoPlayerController != null) {
      _videoPlayerController?.dispose();
    }
    if (_youtubePlayerController != null) {
      _youtubePlayerController?.pause();
      _youtubePlayerController?.dispose();
    }
    if (_desktopYoutubePlayerController != null) {
      _desktopYoutubePlayerController?.stopVideo();
    }
  }

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool isYoutubeLink(String link) {
    // Verifica si el enlace contiene la estructura típica de un enlace de YouTube
    return link.contains('youtube.com') || link.contains('youtu.be');
  }

  String getYouTubeVideoId(String link) {
    Uri uri = Uri.parse(link);
    String videoId = uri.queryParameters['v'] ?? '';
    return videoId;
  }

  @override
  void dispose() {
    // Libera los recursos de los controladores de video al salir del componente
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (isYoutubeLink(widget.url)) {
      // Configuración para enlaces de YouTube
      if (Platform.isAndroid || Platform.isIOS) {
        _youtubePlayerController = mobile_youtube.YoutubePlayerController(
            initialVideoId:
                mobile_youtube.YoutubePlayer.convertUrlToId(widget.url)!,
            flags: mobile_youtube.YoutubePlayerFlags(
              autoPlay: true,
              controlsVisibleAtStart: true,
              mute: false,
            ));
      }
    } else {
      // Configuración para videos no relacionados con YouTube
      _videoPlayerController = VideoPlayerController.network(widget.url);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Center(
              child: Column(
        children: [
          if ((Platform.isAndroid || Platform.isIOS) &&
              isYoutubeLink(widget.url))
            mobile_youtube.YoutubePlayerBuilder(
              player: mobile_youtube.YoutubePlayer(
                controller: _youtubePlayerController!,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return player;
              },
            )
          else if ((Platform.isAndroid || Platform.isIOS) &&
              !isYoutubeLink(widget.url))
            Chewie(controller: _chewieController!)
        ],
      ))),
    );
  }
}
