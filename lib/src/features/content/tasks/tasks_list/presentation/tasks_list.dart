import 'dart:html';

import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';

class TasksList extends StatelessWidget {
  final ITaskService _taskService;

  const TasksList(this._taskService, {super.key});

  _getTaskList() async {
    return _taskService.getTasksList();
  }

  _futureBuilder(BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
    final connectState = snapshot.connectionState;

    if (snapshot.hasError) {
      print(snapshot.error);
      return const Text("error!");
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.connectionState == ConnectionState.done) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: snapshot.data
                ?.map((task) => Text(textAlign: TextAlign.left, task.id))
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
