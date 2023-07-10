import 'package:fisioflex/pages/classes/sharedPreferences.dart';
import 'package:fisioflex/pages/interfaces/interfaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Task>> getTaskService() async {
  final apiBaseUrl = dotenv.env['API_BASE'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.get(
        Uri.parse(
            '${apiBaseUrl!}/assignments/${await getString('idUser')}/tasks'),
        headers: headers);
    if (await response.statusCode >= 200 && await response.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Task> tareas =
          jsonResponse.map((item) => Task.fromJson(item)).toList();
      return tareas;
    } else {
      throw Exception('Error al obtener las tareas: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error al obtener las tareas: ${error.toString()}');
  }
}
