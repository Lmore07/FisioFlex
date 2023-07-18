import 'package:TeraFlex/pages/classes/environment.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/interfaces/tasksInterface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';

Future<TaskResponse> getTaskService(bool isCompleted) async {
  initializeDateFormatting('es');
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  final response = await http.get(
      Uri.parse(
          '${getVariableAPI()}/patients/${await getString('idUser')}/tasks?isCompleted=$isCompleted'),
      headers: headers);
  Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  final List<Task>? taskData = jsonResponse['data'] != null
      ? List<Task>.from(jsonResponse['data'].map((item) => Task.fromJson(item)))
      : null;
  final respuesta = TaskResponse(
      message: jsonResponse['message'],
      data: taskData,
      statusCode: jsonResponse['statusCode'],
      error: jsonResponse['error']);
  return respuesta;
}

Future<bool> completeTaskService(int idAssignment) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.patch(
        Uri.parse('${getVariableAPI()}/assignments/$idAssignment/completed'),
        headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}
