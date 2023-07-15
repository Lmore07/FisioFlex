import 'package:intl/intl.dart';

class Task {
  int id;
  TaskDetail task;
  int estimatedTime;
  DateTime createdAt;
  DateTime dueDate;
  Task({
    required this.id,
    required this.task,
    required this.estimatedTime,
    required this.createdAt,
    required this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        task: TaskDetail.fromJson(json['task']),
        estimatedTime: json['estimatedTime'],
        createdAt: DateFormat('EEEE, MMMM d y, H:mm:ss', 'es')
            .parse(json['createdAt']),
        dueDate: DateFormat('y-M-d').parse(json['dueDate']));
  }
}

class TaskDetail {
  int id;
  String title;
  String description;

  TaskDetail(
      {required this.id, required this.title, required this.description});

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
        id: json['id'], title: json['title'], description: json['description']);
  }
}
