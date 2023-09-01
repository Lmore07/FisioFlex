import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

late YoutubePlayerController youtubePlayerController;

class helpMenu extends StatefulWidget {
  const helpMenu({super.key});

  @override
  State<helpMenu> createState() => _helpMenuState();
}

class _helpMenuState extends State<helpMenu> {
  @override
  void initState() {
    super.initState();
    cargaVideos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(156, 211, 221, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarCustom(
            tittle: 'Ayuda',
            subTittle: 'Atrás',
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              cargaAyudas('¿Como completar tareas?',
                  'https://www.youtube.com/watch?v=I-VKAseJFvc'),
              cargaAyudas('¿Como completar tareas?',
                  'https://www.youtube.com/watch?v=I-VKAseJFvc'),
              cargaAyudas('¿Como completar tareas?',
                  'https://www.youtube.com/watch?v=I-VKAseJFvc'),
              spaced(15, 0)
            ],
          ),
        ),
      ),
    );
  }

  Container cargaAyudas(String title, video) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsetsDirectional.only(top: 15, start: 15, end: 15),
      child: Column(
        children: [
          SizedBox(height: 8),
          textTitleCards(title),
          SizedBox(height: 8),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: YoutubePlayerScaffold(
                builder: (context, player) {
                  return player;
                },
                controller:
                    YoutubePlayerController(params: YoutubePlayerParams())
                      ..loadVideo(video)
                      ..stopVideo(),
              )),
          spaced(15, 0)
        ],
      ),
    );
  }

  Padding textTitleCards(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(label,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Color(0xFF2F2F2F),
              fontSize: 22,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800)),
    );
  }

  void cargaVideos() {
    youtubePlayerController = YoutubePlayerController(
        params: YoutubePlayerParams(
            enableJavaScript: false,
            loop: false,
            showVideoAnnotations: false,
            enableKeyboard: false,
            showFullscreenButton: false,
            showControls: true));
    youtubePlayerController
        .loadVideo('https://www.youtube.com/watch?v=I-VKAseJFvc');
  }
}
