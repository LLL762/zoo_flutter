import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';

class TaskDescribWidget extends StatelessWidget {
  final Task task;

  const TaskDescribWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("description"),
      subtitle: const Text("Show/hide task description"),
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text("${task.description}"),
            ],
          ),
        ),
      ],
    );
  }
}
