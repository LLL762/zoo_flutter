import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zoo_flutter/src/features/content/app_users/model/app_user.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/tasks_list/presentation/card_item/task_list_item_card_top.dart';
import 'package:zoo_flutter/src/features/content/tasks/widget/task_description_widget.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  displayUserInfo(AppUser? user) {
    return "${user?.firstname} ${user?.lastname}";
  }

  Widget buildAssignTo() {
    String assignToInfos =
        task.assignTo.map((user) => displayUserInfo(user)).join(", ");

    if (assignToInfos.isEmpty) {
      assignToInfos = "Unknown user";
    }

    return buildRow(
        Text(overflow: TextOverflow.ellipsis, "Assign to : $assignToInfos"));
  }

  Widget buildCreatedBy() {
    String userInfos = displayUserInfo(task.createdBy);

    if (userInfos.isEmpty) {
      userInfos = "nobody";
    }

    final formattedCreatedAt =
        DateFormat('yyyy-MM-dd, kk:mm').format(task.createdAt);

    return buildRow(Text("Created by : $userInfos at $formattedCreatedAt"));
  }

  Widget buildRow(Widget widget) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [widget, const Divider(endIndent: 50, color: Colors.blue)],
      ),
    );
  }

  buildContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TaskListItemTop(task: task),
      buildCreatedBy(),
      buildAssignTo(),
      TaskDescribWidget(task: task),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600, minWidth: 300),
      padding: const EdgeInsets.all(8.0),
      child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => context.go("/tasks/${task.id}"),
            child: Padding(
                padding: const EdgeInsets.all(10), child: buildContent()),
          )),
    );
  }
}
