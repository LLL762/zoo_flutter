import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/widget/priority_icon.dart';
import 'package:zoo_flutter/src/features/content/tasks/widget/task_status_icon.dart';
import 'package:zoo_flutter/src/widgets/card/card_title.dart';

class TaskListItemTop extends StatelessWidget {
  final Task task;

  const TaskListItemTop({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(minWidth: double.infinity, minHeight: 50),
      child: Stack(
        alignment: const Alignment(0.0, -1),
        children: [
          Positioned(left: 5, child: TaskStatusWidget(task: task)),
          CardTitle(title: task.name),
          Positioned(right: 5, child: TaskPriorityIcon(task))
        ],
      ),
    );
  }
}
