import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    if (isYoutubeLink(videoUrl)) {
      // Si es un enlace de YouTube, utiliza YoutubePlayer
      String videoId = getYouTubeVideoId(videoUrl);
      return SafeArea(
        child: Container(
          child: Center(
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                    autoPlay: true, mute: false, controlsVisibleAtStart: true),
              ),
              showVideoProgressIndicator: true,
            ),
          ),
        ),
      );
    } else {
      // Si no es un enlace de YouTube, utiliza VideoPlayer
      VideoPlayerController videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      return Scaffold(
        body: Container(
          child: Center(
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
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
