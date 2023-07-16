import 'package:TeraFlex/pages/interfaces/interfaces.dart';

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

class AssginmentResponse extends GeneralResponse<Assignment> {
  AssginmentResponse(
      {Assignment? data, String? message, int? statusCode, String? error})
      : super(
            data: data, message: message, statusCode: statusCode, error: error);
}
