
import 'package:esferasoft/controllers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../appdata/route_names.dart';
import '../../models/task_model.dart';
import 'create_task.dart';

class AllTasks extends ConsumerStatefulWidget {
  const AllTasks({super.key});

  @override
  AllTasksState createState() => AllTasksState();
}

class AllTasksState extends ConsumerState<AllTasks> {
  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = ref.watch(tasksProvider);

    if (tasks.isEmpty){
      return const CreateTask();
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text("All Tasks ${tasks.length}"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              onTap: (){
                context.goNamed(AppRoutes.taskDetails, pathParameters: {'taskID' : tasks[index].taskId});
              },
              leading: Column(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(5),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                    ),
                    icon: Icon(
                      tasks[index].isCompleted
                        ? Icons.check_circle
                        : Icons.flag_circle,
                      color: tasks[index].isCompleted
                        ? Colors.green
                        : Colors.blue,
                    ),
                    onPressed: (){
                      ref.read<TasksNotifier>(tasksProvider.notifier).toggleTaskStatus(tasks[index].taskId);
                    },
                  ),
                  Text(
                    tasks[index].isCompleted
                        ? 'Completed'
                        : 'Pending',
                    style: const TextStyle(
                      fontSize: 8
                    ),
                  )
                ],
              ),
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].description, maxLines: 1, overflow: TextOverflow.ellipsis,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: index % 2 == 0 ? Colors.blue[100] : Colors.yellow[100],
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red,),
                onPressed: (){
                  ref.read<TasksNotifier>(tasksProvider.notifier).deleteTask(tasks[index].taskId);
                },
              ),
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Create Task'),
        icon: const Icon(Icons.add),
        onPressed: (){
          context.goNamed(AppRoutes.createTask);
        },
      ),
    );
  }
}