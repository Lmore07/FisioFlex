import 'package:TeraFlex/pages/interfaces/interfaces.dart';
import 'package:intl/intl.dart';

class Task {
  int id;
  TaskDetail task;
  DateTime createdAt;
  DateTime dueDate;
  Task({
    required this.id,
    required this.task,
    required this.createdAt,
    required this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        task: TaskDetail.fromJson(json['task']),
        createdAt:
            DateFormat('EEEE, MMMM d y, H:mm', 'es').parse(json['createdAt']),
        dueDate: DateFormat('y-M-d').parse(json['dueDate']));
  }
}

class TaskDetail {
  int id;
  String title;
  String? description;
  int? estimatedTime;

  TaskDetail(
      {required this.id,
      required this.title,
      this.description,
      this.estimatedTime});

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        estimatedTime: json['estimatedTime']);
  }
}

class TaskResponse extends GeneralResponse<List<Task>> {
  TaskResponse(
      {List<Task>? data, String? message, int? statusCode, String? error})
      : super(
            data: data, message: message, statusCode: statusCode, error: error);
}
