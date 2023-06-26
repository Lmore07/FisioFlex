import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loginService(String user, String password) async {
  final apiBaseUrl = dotenv.env['API_BASE_URL'];
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final body = jsonEncode({});

  try {
    final response = await http.post(Uri.parse(apiBaseUrl! + 'posts'),
        body: body, headers: headers);
    print(await response.body);
  } catch (error) {
    print(error);
  }
}
