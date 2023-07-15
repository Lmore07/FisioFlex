import 'package:TeraFlex/pages/interfaces/interfaces.dart';

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String docNumber;
  final String? phone;
  final String? description;
  final String? birthDate;

  UserData(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.phone,
      this.description,
      this.birthDate,
      required this.docNumber});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      docNumber: json['docNumber'],
      phone: json['phone'],
      description: json['description'],
      birthDate: json['birthDate'],
      id: json['id'],
    );
  }
}

class UserResponse extends GeneralResponse<UserData> {
  UserResponse({UserData? data, String? message})
      : super(data: data, message: message);
}


