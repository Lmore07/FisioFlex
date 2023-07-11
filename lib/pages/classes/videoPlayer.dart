import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

ChewieController? _chewieController;
VideoPlayerController? _videoPlayerController;
YoutubePlayerController? _youtubePlayerController;

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
  }

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool isYoutubeLink(String link) {
    // Verifica si el enlace contiene la estructura típica de un enlace de YouTube
    return link.contains('youtube.com') || link.contains('youtu.be');
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
      _youtubePlayerController = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            controlsVisibleAtStart: true,
            mute: false,
          ));
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
              child: isYoutubeLink(widget.url)
                  ? YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _youtubePlayerController!,
                        showVideoProgressIndicator: true,
                      ),
                      builder: (context, player) {
                        return player;
                      },
                    )
                  : Chewie(controller: _chewieController!))),
    );
  }
}
