import 'package:TeraFlex/pages/classes/environment.dart';
import 'package:TeraFlex/pages/interfaces/assignmentInterface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';

Future<AssginmentResponse> assignmentDetailService(int idAssignment) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  final response = await http.get(
      Uri.parse('${getVariableAPI()}/assignments/$idAssignment/task'),
      headers: headers);
  Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  ;
  final respuesta = AssginmentResponse(
      message: jsonResponse['message'],
      data: Assignment.fromJson(jsonResponse['data']),
      error: jsonResponse['error'],
      statusCode: jsonResponse['statusCode']);
  return respuesta;
}
