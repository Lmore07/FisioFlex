import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<List<Task>> getTaskService(bool isCompleted) async {
  initializeDateFormatting('es');
  final apiBaseUrl = dotenv.env['API_BASE'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.get(
        Uri.parse(
            '${apiBaseUrl!}/patients/${await getString('idUser')}/tasks?isCompleted=$isCompleted'),
        headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
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

Future<bool> completeTaskService(int idAssignment) async {
  final apiBaseUrl = dotenv.env['API_BASE'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.patch(
        Uri.parse('${apiBaseUrl!}/assigments/$idAssignment/completed'),
        headers: headers);
    if (await response.statusCode >= 200 && await response.statusCode < 300) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}
