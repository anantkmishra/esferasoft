import 'package:esferasoft/controllers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../appdata/route_names.dart';
import '../../models/task_model.dart';

class CreateTask extends ConsumerStatefulWidget {
  const CreateTask({super.key});

  @override
  CreateTaskState createState() => CreateTaskState();
}

class CreateTaskState extends ConsumerState<CreateTask> {

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(tasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Task',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300
                ),
              ),
              TextField(
                controller: _title,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.red[100],
                  hintText: 'Title...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red)
                  )
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Description...',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300
                ),
              ),
              TextField(
                controller: _description,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green[100],
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)
                    )
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, color: Colors.white,),
                onPressed: (){
                  if (_title.text.isNotEmpty && _description.text.isNotEmpty){
                    createTask();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Colors.blue[700],
                  minimumSize: const Size.fromHeight(50),
                ),
                label: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 22),),
              ),
            ],
          ),
        ),
      )
    );
  }

  createTask(){
    final Task task = Task(
      taskId: DateTime.now().millisecondsSinceEpoch.toString() ,
      title: _title.text.trim(),
      description: _description.text.trim(),
      isCompleted: false,
    );
    ref.read(tasksProvider.notifier).createTask(task);
    _title.clear();
    _description.clear();
    FocusScope.of(context).unfocus();
    if(context.canPop()){
      context.pop();
    } else {
      context.goNamed(AppRoutes.allTasks);
    }
  }
}