import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';

class TaskService implements ITaskService {
  final tasksUrl = "http://localhost:3000/api/tasks";
  final ILogInService _logInService;

  const TaskService(this._logInService);

  @override
  Future<List<Task>> getTasksList() async {
    final bearerToken = await _logInService.getBearerToken();

    final resp = await http.get(Uri.parse(tasksUrl), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: bearerToken ?? ""
    });

    print(resp.statusCode);
    print(jsonDecode(resp.body)["data"]["tasks"][0]);

    return Task.fromJsonArray(jsonDecode(resp.body)["data"]["tasks"]);
  }
}
