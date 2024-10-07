import 'package:esferasoft/presentation/tasks/create_task.dart';
import 'package:esferasoft/presentation/tasks/task_details.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:esferasoft/presentation/tasks/all_tasks.dart';
import 'package:esferasoft/controllers/task_provider.dart';

import '../main.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> get navKey => _navKey;

final GoRouter appRoutes = GoRouter(
  navigatorKey: _navKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'allTasks',
      builder: (BuildContext context, GoRouterState state) {
        return const AllTasks();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'create',
          name: 'createTask',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateTask();
          },
        ),
        GoRoute(
          path: ':taskID',
          name: 'taskDetails',
          builder: (BuildContext context, GoRouterState state) {
            final id = state.pathParameters['taskID']!;
            return TaskDetails(taskId: id);
          },
        ),
      ],
    ),
  ],
);