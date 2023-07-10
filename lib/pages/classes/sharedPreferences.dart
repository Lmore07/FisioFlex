import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Guardar un objeto JSON
Future<void> saveJson(String key, Map<String, dynamic> json) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(json);
  await prefs.setString(key, jsonString);
}

// Guardar un string
Future<void> saveString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

// Obtener un string
Future<String?> getString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  if (value != null) {
    return value;
  }
  return null;
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

// Eliminar un objeto JSON
Future<bool?> removeData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (await prefs.remove(key)) {
    return true;
  }
  return null;
}
