import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast(String msg, {Color? backgroundColor, Color? foregroundColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.black,
    textColor: foregroundColor ?? Colors.white,
    fontSize: 16.0,
  );
}

String getMessageVoice(
    String? name, String title, String description, int timeExpected) {
  final List<String> messages = [
    'Hola $name, tu tarea "${title}" consiste en ${description}. Te recomiendo dedicar al menos ${timeExpected} minutos para completarla.',
    '¡Hola $name! No olvides realizar la tarea "${title}". Es importante ${description}. Asigna al menos ${timeExpected} minutos para ello.',
    'Hola $name, recuerda que tienes la tarea "${title}". Asegúrate de ${description} y toma al menos ${timeExpected} minutos para completarla.',
    '¡Hola $name! Quiero recordarte sobre la tarea "${title}". Asegúrate de ${description} y reserva ${timeExpected} minutos para completarla.',
    'Hola $name, no olvides la tarea "${title}". Debes ${description} y tomar al menos ${timeExpected} minutos para finalizarla.',
    '¡Hola $name! Te recuerdo que debes realizar la tarea "${title}". Asegúrate de ${description} y asigna ${timeExpected} minutos para ello.',
    'Hola $name, no descuides la tarea "${title}". Es importante ${description} y requiere al menos ${timeExpected} minutos de tu tiempo.',
    '¡Hola $name! No olvides dedicar tiempo a la tarea "${title}". Recuerda ${description} y toma ${timeExpected} minutos para realizarla correctamente.',
    'Hola $name, ten en cuenta la tarea "${title}". Es necesario ${description} y debes invertir al menos ${timeExpected} minutos en ello.',
    '¡Hola $name! No pierdas de vista la tarea "${title}". Recuerda ${description} y reserva ${timeExpected} minutos para completarla exitosamente.',
  ];

  final random = Random();
  final randomMessage = messages[random.nextInt(messages.length)];

  return randomMessage;
}
