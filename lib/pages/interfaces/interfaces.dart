import 'package:intl/intl.dart';

class Credentials {
  final String user;
  final String password;

  Credentials({required this.user, required this.password});
}

class GeneralResponse<T> {
  final T? data;
  final String? message;

  GeneralResponse({this.data, this.message});
}

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

class Assignment {
  final int assignmentId;
  final int taskId;
  final String title;
  final String? description;
  final int estimatedTime;
  final bool isCompleted;
  final String createdAt;
  final String dueDate;
  final List<AssignmentFile> files;

  Assignment({
    required this.assignmentId,
    required this.taskId,
    required this.title,
    this.description,
    required this.estimatedTime,
    required this.isCompleted,
    required this.createdAt,
    required this.dueDate,
    required this.files,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    List<dynamic> filesJson = json['files'];

    List<AssignmentFile> files =
        filesJson.map((fileJson) => AssignmentFile.fromJson(fileJson)).toList();

    return Assignment(
      assignmentId: json['assignmentId'],
      taskId: json['taskId'],
      title: json['title'],
      description: json['description'],
      estimatedTime: json['estimatedTime'],
      isCompleted: json['isCompleted'],
      createdAt: json['createdAt'],
      dueDate: json['dueDate'],
      files: files,
    );
  }
}

class AssignmentFile {
  final int id;
  final String url;
  final String type;

  AssignmentFile({
    required this.id,
    required this.url,
    required this.type,
  });

  factory AssignmentFile.fromJson(Map<String, dynamic> json) {
    return AssignmentFile(
      id: json['id'],
      url: json['url'],
      type: json['type'],
    );
  }
}
