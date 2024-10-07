import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:esferasoft/models/task_model.dart';

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>> ((ref) => TasksNotifier());

class TasksNotifier extends StateNotifier<List<Task>>{

  TasksNotifier() : super(<Task>[]);

  createTask(Task task){
    state = [...state,task];
  }

  deleteTask(String taskID){
    state = state.where((task) => task.taskId != taskID).toList() ;
  }

  toggleTaskStatus(String taskID){
    state = [
      for (final task in state)
        if (task.taskId == taskID)
          task.copyWith(isCompleted: !task.isCompleted, taskId: task.taskId,)
        else
          task
      ,
    ];
  }

}