import 'package:TeraFlex/pages/classes/decodeJWT.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:TeraFlex/pages/services/myInfoService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> loginService(Credentials credentials) async {
  final apiBaseUrl = dotenv.env['API_BASE'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'identification': credentials.user,
    'password': credentials.password
  };
  final body = jsonEncode({});

  try {
    final response = await http.post(Uri.parse('${apiBaseUrl!}/auth/login'),
        body: body, headers: headers);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await saveString('token', jsonResponse['token']);
      LoginInformation decoded = decodificarToken(jsonResponse['token']);
      await saveString('idUser', decoded.id.toString());
      await saveString('docNumber', decoded.docNumber);
      if (decoded.role != 'PATIENT') {
        return 'NO_GRANTED';
      }
      await myInfoService();
      return 'OK';
    } else {
      return jsonResponse['message'];
    }
  } catch (error) {
    return error.toString();
  }
}
