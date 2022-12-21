import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';

class TasksList extends StatelessWidget {
  final ITaskService _taskService;

  const TasksList(this._taskService, {super.key});

  _futureBuilder(BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
    if (snapshot.hasError) {
      return const Text("error!");
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.connectionState == ConnectionState.done) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: snapshot.data
                ?.map((task) => Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                        onTap: () => context.go("/tasks/${task.id}"),
                        child: Text(textAlign: TextAlign.left, task.id))))
                .toList() ??
            [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _taskService.getTasksList(),
      builder: (context, snapshot) => _futureBuilder(context, snapshot),
    );
  }
}
