import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zoo_flutter/src/features/authentication/services/i_api_req_service.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/model/task.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';

class TaskService implements ITaskService {
  final tasksUrl = "http://localhost:3000/api/tasks";
  final ILogInService _logInService;
  final IApiRequestService apiReqService = IApiRequestService();

  TaskService(this._logInService);

  @override
  Future<List<Task>> getTasksList() async {
    final resp = await apiReqService.makeApiRequest(url: tasksUrl);
    return Task.fromJsonArray(jsonDecode(resp.body)["data"]["tasks"]);
  }

  @override
  Future<Task> getTaskDetail(String id) async {
    final bearerToken = await _logInService.getBearerToken();

    final resp = await http.get(Uri.parse("$tasksUrl/$id"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: bearerToken ?? ""
    });

    return Task.fromMap(jsonDecode(resp.body)["data"]);
  }
}
