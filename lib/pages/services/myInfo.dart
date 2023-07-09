import 'package:fisioflex/pages/classes/messages.dart';
import 'package:fisioflex/pages/classes/sharedPreferences.dart';
import 'package:fisioflex/pages/interfaces/interfaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

Future<MyInformation> myInfoService() async {
  final apiBaseUrl = dotenv.env['API_AUTH'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final body = jsonEncode({});

  try {
    final response = await http.post(Uri.parse(apiBaseUrl! + 'login'),
        body: body, headers: headers);
    print(await response);
    if (await response.statusCode >= 200 && await response.statusCode < 300) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return MyInformation.fromJson(jsonResponse);
    } else {
      showToast(response.reasonPhrase!);
      return MyInformation();
    }
  } catch (error) {
    showToast(error.toString());
    return MyInformation();
  }
}
