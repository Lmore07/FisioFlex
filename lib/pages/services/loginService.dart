import 'package:fisioflex/pages/classes/alerts.dart';
import 'package:fisioflex/pages/classes/decodeJWT.dart';
import 'package:fisioflex/pages/classes/messages.dart';
import 'package:fisioflex/pages/classes/sharedPreferences.dart';
import 'package:fisioflex/pages/interfaces/interfaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

Future<int> loginService(Credentials credentials) async {
  final apiBaseUrl = dotenv.env['API_BASE'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'identification': credentials.user,
    'password': credentials.password
  };
  final body = jsonEncode({});

  try {
    final response = await http.post(Uri.parse(apiBaseUrl! + '/auth/login'),
        body: body, headers: headers);
    if (await response.statusCode >= 200 && await response.statusCode < 300) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      await saveString('token', jsonResponse['token']);
      LoginInformation decoded = decodificarToken(jsonResponse['token']);
      await saveString('idUser', decoded.id.toString());
      await saveString('docNumber', decoded.docNumber);
      if (decoded.role != 'PATIENT') {
        return 0;
      }
      return 1;
    } else {
      return 2;
    }
  } catch (error) {
    return 3;
  }
}
