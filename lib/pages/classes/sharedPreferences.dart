import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Guardar un objeto JSON
Future<void> saveJson(String key, Map<String, dynamic> json) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(json);
  await prefs.setString(key, jsonString);
}

// Obtener un objeto JSON
Future<Map<String, dynamic>?> getJson(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString(key);
  if (jsonString != null) {
    return jsonDecode(jsonString);
  }
  return null;
}
