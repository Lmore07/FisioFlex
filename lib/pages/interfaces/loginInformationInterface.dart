import 'package:TeraFlex/pages/interfaces/interfaces.dart';

class LoginInformation {
  final int id;
  final String docNumber;
  final String role;
  final dynamic iat;
  final dynamic exp;

  LoginInformation(
      {required this.id,
      required this.docNumber,
      required this.role,
      required this.exp,
      required this.iat});
  factory LoginInformation.fromJson(Map<String, dynamic> json) {
    return LoginInformation(
      id: json['id'],
      docNumber: json['docNumber'],
      role: json['role'],
      exp: json['exp'],
      iat: json['iat'],
    );
  }
}

class LoginResponse extends GeneralResponse<LoginInformation> {
  LoginResponse(
      {LoginInformation? data, String? message, int? statusCode, String? error})
      : super(
            data: data, message: message, statusCode: statusCode, error: error);
}
