import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> myInfoService() async {
  final apiBaseUrl = dotenv.env['API_BASE'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.get(Uri.parse(apiBaseUrl! + '/user/my-profile'),
        headers: headers);
    if (await response.statusCode >= 200 && await response.statusCode < 300) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      saveJson('userInformation', jsonResponse['data']);
    } else {
      throw 'ERROR_INFO';
    }
  } catch (error) {
    throw error.toString();
  }
}

UserData processData(Map<String, dynamic> response) {
  final userData = UserData(
    id: response['data']['id'],
    firstName: response['data']['firstName'],
    lastName: response['data']['lastName'],
    docNumber: response['data']['docNumber'],
    phone: response['data']['phone'],
    description: response['data']['description'],
    birthDate: response['data']['birthDate'],
  );
  return userData;
}
