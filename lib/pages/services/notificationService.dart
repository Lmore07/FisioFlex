import 'package:TeraFlex/pages/classes/environment.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/interfaces/notificationInterface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> updateDevice() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'Authorization': 'Bearer ${await getString('token')}'
  };
  final body = jsonEncode({});

  try {
    final response = await http.patch(
        Uri.parse(
            '${getVariableAPI()}/notification-token/update-device/status/${await getString("imei")}'),
        body: body,
        headers: headers);
    print(response);
  } catch (error) {
    print(error.toString());
  }
}

Future<void> saveDevice() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'Authorization': 'Bearer ${await getString('token')}'
  };
  final body = jsonEncode({
    "device": await getString("imei"),
    "token": await getString("tokenNotification")
  });

  try {
    final response = await http.post(
        Uri.parse('${getVariableAPI()}/notification-token/register-device'),
        body: body,
        headers: headers);
    print(response);
  } catch (error) {
    print(error.toString());
  }
}

Future<NotificationResponse> getAllNotifications() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.get(
        Uri.parse('${getVariableAPI()}/notification/all'),
        headers: headers);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<NotificationI>? notificationData = jsonResponse['data'] != null
        ? List<NotificationI>.from(
            jsonResponse['data'].map((item) => NotificationI.fromJson(item)))
        : null;
    return NotificationResponse(
        message: jsonResponse['message'],
        data: notificationData,
        statusCode: jsonResponse['statusCode'],
        error: jsonResponse['error']);
  } catch (error) {
    print(error.toString());
    throw error;
  }
}

Future<NotificationResponse> deleteNotification(int id) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.delete(
        Uri.parse('${getVariableAPI()}/notification/delete/$id'),
        headers: headers);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return NotificationResponse(
        message: jsonResponse['message'],
        data: null,
        statusCode: jsonResponse['statusCode'],
        error: jsonResponse['error']);
  } catch (error) {
    print(error.toString());
    throw error;
  }
}

Future<NotificationResponse> verificationDevice() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'Authorization': 'Bearer ${await getString('token')}'
  };

  try {
    final response = await http.get(
        Uri.parse(
            '${getVariableAPI()}/notification-token/verify-device/${await getString("imei")}'),
        headers: headers);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return NotificationResponse(
        message: jsonResponse['message'],
        data: null,
        statusCode: jsonResponse['statusCode'],
        error: jsonResponse['error']);
  } catch (error) {
    print(error.toString());
    throw error;
  }
}
