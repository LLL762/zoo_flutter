import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoo_flutter/main.dart';
import 'package:zoo_flutter/src/features/authentication/util/i_guard_util.dart';
import 'package:zoo_flutter/src/features/content/tasks/presentation/task_detail.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';
import 'package:zoo_flutter/src/router/i_route_container.dart';

class TasksRoutes implements IRouteContainer {
  final IGuardUtil guardUtil = IGuardUtil();

  late final routes = [
    GoRoute(
        path: 'tasks',
        builder: (BuildContext context, GoRouterState state) {
          return const DetailsScreen();
        },
        redirect: (context, state) async {
          return guardUtil.needAuth();
        },
        routes: [taskDetailRoute]),
  ];

  late final taskDetailRoute = GoRoute(
      path: ':id',
      builder: (BuildContext context, GoRouterState state) {
        return TaskDetail(ITaskService(""), state.params['id']!);
      },
      redirect: (context, state) async {
        return guardUtil.needAuth();
      });

  @override
  List<GoRoute> get() {
    return routes;
  }
}
