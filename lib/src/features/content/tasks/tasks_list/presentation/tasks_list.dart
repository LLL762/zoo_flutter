import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/tasks_list/presentation/card_item/task_list_item_card.dart';

class TasksList extends StatelessWidget {
  final ITaskService _taskService;

  const TasksList(this._taskService, {super.key});

  _futureBuilder(BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
    if (snapshot.hasError) {
      print(snapshot.error);

      return const Text("error!");
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.connectionState == ConnectionState.done) {
      return Container(
        constraints: const BoxConstraints(minWidth: 300),
        child: Wrap(
          children: snapshot.data
                  ?.map((task) => Column(children: [
                        TaskListItem(task: task),
                        const SizedBox(
                          height: 10,
                        )
                      ]))
                  .toList() ??
              [],
        ),
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
