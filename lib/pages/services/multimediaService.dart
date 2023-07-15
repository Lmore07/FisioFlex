import 'dart:io';

import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

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

Future<File> downloadFileService(int idFile) async {
  final apiBaseUrl = dotenv.env['API_BASE'];
  Map<String, String> headers = {
    'Content-Type': 'application/octet-stream;',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    WidgetsFlutterBinding
        .ensureInitialized(); // Asegura la inicialización de Flutter
    final response = await http.get(
        Uri.parse('${apiBaseUrl!}/multimedia/download/$idFile'),
        headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final bytes = response.bodyBytes;
      final tempDir = await getApplicationDocumentsDirectory();
      final tempPath =
          '${tempDir.path}/${response.headers['x-processed-filename']!}';
      final file = File(tempPath);
      await file.writeAsBytes(bytes);
      return file;
    } else {
      throw Exception('Error al obtener las tareas: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error al obtener las tareas: ${error.toString()}');
  }
}

String? extensionFile(String link) {
  final RegExp regExp = RegExp(
      r'\.(\w+)$'); // Expresión regular para extraer la extensión del archivo
  final match = regExp.firstMatch(link);
  if (match != null) {
    final extension = match.group(1)?.toLowerCase();
    return extension;
  } else {
    return "jpg";
  }
}
