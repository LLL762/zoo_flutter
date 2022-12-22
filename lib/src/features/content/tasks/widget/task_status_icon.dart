import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';

class TaskStatusWidget extends StatelessWidget {
  final Task task;

  const TaskStatusWidget({super.key, required this.task});

  String formatStatus(String value) {
    return value.replaceAll("_", " ");
  }

  @override
  Widget build(BuildContext context) {
    final status = task.status;

    if (task.status == null) {
      return const Tooltip(
          message: "Status unknown",
          child: Icon(color: Colors.grey, Icons.question_mark));
    }

    if (task.status == "DONE") {
      return const Tooltip(
          message: "Status : DONE",
          child: Icon(color: Colors.green, Icons.check_circle_outline));
    }

    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Text(overflow: TextOverflow.ellipsis, formatStatus(status!)));
  }
}
