import 'package:esferasoft/controllers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/task_model.dart';

class TaskDetails extends ConsumerStatefulWidget {
  const TaskDetails({super.key, required this.taskId});
  final String taskId;

  @override
  TaskDetailsState createState() => TaskDetailsState();
}

class TaskDetailsState extends ConsumerState<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    final Task task = ref.watch(tasksProvider).firstWhere((t) => t.taskId == widget.taskId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    task.description,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Task ID',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    task.taskId,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Task Status',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      ref.read<TasksNotifier>(tasksProvider.notifier).toggleTaskStatus(task.taskId);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: task.isCompleted ? Colors.green[200] : Colors.orange[200],
                    ),
                    child: Text(
                      task.isCompleted ? "Completed" : "Pending",
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      )
    );
  }
}