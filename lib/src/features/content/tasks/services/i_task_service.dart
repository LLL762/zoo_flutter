import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/tasks_service.dart';

abstract class ITaskService {
  static ITaskService? _instance;

  factory ITaskService(String profile) {
    _instance ??= TaskService(ILogInService(profile));

    return _instance!;
  }

  Future<List<Task>> getTasksList();
  Future<Task> getTaskDetail(String id);
}
