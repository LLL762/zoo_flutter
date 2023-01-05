import 'package:zoo_flutter/src/features/authentication/services/api_req_service.dart';
import 'package:http/http.dart' as http;

enum EHttpMethods { get, post, put, patch }

abstract class IApiRequestService {
  static IApiRequestService? _instance;

  factory IApiRequestService([String? profile]) {
    _instance ??= ApiReqService();
    return _instance!;
  }

  Future<http.Response> makeApiRequest(
      {EHttpMethods method = EHttpMethods.get,
      bool needToken = true,
      required String url,
      Object? body});
}
