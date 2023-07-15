import 'package:TeraFlex/pages/classes/environment.dart';
import 'package:TeraFlex/pages/interfaces/assignmentInterface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';

Future<Assignment> assignmentDetailService(int idAssignment) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.get(
        Uri.parse('${getVariableAPI()}/assignments/$idAssignment/task'),
        headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Assignment.fromJson(jsonResponse);
    } else {
      throw Exception(
          'Error al obtener el detalle de la tarea: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception(
        'Error al obtener el detalle de la tarea: ${error.toString()}');
  }
}
