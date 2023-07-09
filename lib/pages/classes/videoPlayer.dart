import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    late ChewieController _chewieController;
    late VideoPlayerController _videoPlayerController;

    if (isYoutubeLink(videoUrl)) {
      // Si es un enlace de YouTube, utiliza YoutubePlayer
      YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          controlsVisibleAtStart: true,
          mute: false,
        ),
      );
      return SafeArea(
        child: Container(
          child: Center(
            child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
                builder: (context, player) {
                  return player;
                }),
          ),
        ),
      );
    } else {
      _videoPlayerController = VideoPlayerController.network(videoUrl);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
      );

      // Si no es un enlace de YouTube, utiliza VideoPlayer
      VideoPlayerController videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl))..initialize();
      return SafeArea(
        child: Container(
          child: Center(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ),
      );
    }
  }

  bool isYoutubeLink(String link) {
    // Verifica si el enlace contiene la estructura típica de un enlace de YouTube
    return link.contains('youtube.com') || link.contains('youtu.be');
  }

  String getYouTubeVideoId(String link) {
    // Obtiene el ID del video de YouTube a partir del enlace
    Uri uri = Uri.parse(link);
    String videoId = uri.queryParameters['v'] ?? '';
    return videoId;
  }
}
