import 'package:flutter/cupertino.dart';

@immutable
class Task{

  final String taskId;
  final String title;
  final String description;
  final bool isCompleted;

  const Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  Task copyWith({String? taskId,String? title, String? description, bool? isCompleted}){
    return Task(
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

}