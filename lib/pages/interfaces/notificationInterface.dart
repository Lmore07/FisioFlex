import 'package:TeraFlex/pages/interfaces/interfaces.dart';

class NotificationI {
  final int id;
  final String title;
  final String body;
  final int userId;
  final bool status;
  final String createdAt;
  final String updateAt;

  NotificationI({
    required this.id,
    required this.body,
    required this.title,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updateAt,
  });

  factory NotificationI.fromJson(Map<String, dynamic> json) {
    return NotificationI(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      status: json['status'],
      createdAt: json['createdAt'],
      updateAt: json['updatedAt'],
    );
  }
}

class NotificationResponse extends GeneralResponse<List<NotificationI>> {
  NotificationResponse(
      {List<NotificationI>? data,
      String? message,
      int? statusCode,
      String? error})
      : super(
            data: data, message: message, statusCode: statusCode, error: error);
}
