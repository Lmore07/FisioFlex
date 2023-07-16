import 'dart:convert';
import 'package:TeraFlex/pages/interfaces/userInterface.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Guardar un objeto JSON
Future<void> saveJson(String key, Map<String, dynamic> json) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(json);
  await prefs.setString(key, jsonString);
}

Future<void> clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

// Guardar un objeto JSON
Future<UserData?> getUserInformation(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString(key);
  if (jsonString != null) {
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    UserData userResponse = UserData.fromJson(jsonData);
    return userResponse;
  }
  return null;
}

// Guardar un string
Future<void> saveString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

// Guardar un string
Future<void> saveListString(String key, List<dynamic> json) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(json);
  await prefs.setString(key, jsonString);
}

Future<List<dynamic>> getListString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? videoUrlsJson = prefs.getString(key);
  if (videoUrlsJson != null) {
    // Convierte la cadena JSON de nuevo a una lista de strings
    List<dynamic> videoUrlsData = jsonDecode(videoUrlsJson);
    List<dynamic> videoUrls = videoUrlsData.cast<String>();
    return videoUrls;
  }
  return [];
}

Future<List<int>> getListInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? videoUrlsJson = prefs.getString(key);
  if (videoUrlsJson != null) {
    // Convierte la cadena JSON de nuevo a una lista de strings
    List<dynamic> videoUrlsData = jsonDecode(videoUrlsJson);
    List<int> videoUrls = videoUrlsData.cast<int>();
    return videoUrls;
  }
  return [];
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
