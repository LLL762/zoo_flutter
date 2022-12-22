import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';

class TaskPriorityIcon extends StatelessWidget {
  final Task _task;

  const TaskPriorityIcon(this._task, {super.key});

  buildIcon() {
    final priority = _task.priority;

    if (priority == null || priority < 0) {
      return const Icon(color: Colors.grey, Icons.question_mark);
    }

    if (priority >= 75) {
      return const Icon(color: Colors.red, Icons.keyboard_double_arrow_up);
    }

    if (priority >= 50) {
      return const Icon(color: Colors.orange, Icons.keyboard_double_arrow_up);
    }

    if (priority >= 25) {
      return const Icon(
          color: Color.fromARGB(255, 187, 201, 61), Icons.keyboard_arrow_up);
    }

    return const Icon(color: Colors.green, Icons.keyboard_arrow_up);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: "priority : ${_task.priority ?? "unknown"}",
        child: buildIcon());
  }
}
