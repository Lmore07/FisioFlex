import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  late FlutterTts _flutterTts;

  TextToSpeech() {
    _flutterTts = FlutterTts();
    _configureTts();
  }

  Future<void> _configureTts() async {
    await _flutterTts.setLanguage('es-ES');
    await _flutterTts
        .setSpeechRate(0.6); // Ajustar la velocidad de habla (0.5 - 2.0)
    await _flutterTts
        .setVolume(1.0); // Ajustar el volumen de la voz (0.0 - 1.0)
    await _flutterTts.setPitch(0.8); // Ajustar el tono de la voz (0.5 - 2.0)
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
