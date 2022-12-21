import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';

class TaskDetail extends StatelessWidget {
  final ITaskService _taskService;
  final String _taskId;

  const TaskDetail(this._taskService, this._taskId, {super.key});

  _futureBuilder(BuildContext context, AsyncSnapshot<Task> snapshot) {
    if (snapshot.hasError) {
      return const Text("error!");
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.connectionState == ConnectionState.done) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(snapshot.data?.id ?? ""),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Task>(
      future: _taskService.getTaskDetail(_taskId),
      builder: (context, snapshot) => _futureBuilder(context, snapshot),
    );
  }
}
