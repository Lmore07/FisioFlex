class Credentials {
  final String user;
  final String password;

  Credentials({required this.user, required this.password});
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

class MyInformation {
  final String? names;
  final String? image;
  final String? identification;
  final String? phone;
  final String? description;

  MyInformation(
      {this.names,
      this.image,
      this.identification,
      this.phone,
      this.description});
  factory MyInformation.fromJson(Map<String, dynamic> json) {
    return MyInformation(
      names: json['names'],
      image: json['image'],
      identification: json['identification'],
      phone: json['phone'],
      description: json['description'],
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
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: DateTime.parse(json['dueDate']),
    );
  }
}

class TaskDetail {
  int id;
  String title;

  TaskDetail({
    required this.id,
    required this.title,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
      id: json['id'],
      title: json['title'],
    );
  }
}

