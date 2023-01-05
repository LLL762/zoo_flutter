import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zoo_flutter/src/features/authentication/model/log_in_status.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_api_req_service.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';

class ApiReqService implements IApiRequestService {
  final ILogInService loginService = ILogInService("");

  Future<String?> getBearer() async {
    final loginStatus = await loginService.getLogInStatus();

    print(loginStatus);
    switch (loginStatus) {
      case LogInStatus.logIn:
        break;
      case LogInStatus.needRefresh:
        await loginService.refreshTokens();
        break;
      default:
        throw Exception();
    }
    return loginService.getBearerToken();
  }

  @override
  makeApiRequest(
      {EHttpMethods method = EHttpMethods.get,
      bool needToken = true,
      required String url,
      Object? body}) async {
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};

    if (needToken) {
      final bearer = await getBearer();
      if (bearer == null) {
        throw Exception();
      }
      headers[HttpHeaders.authorizationHeader] = bearer;
    }

    final parsedUrl = Uri.parse(url);

    if (method == EHttpMethods.get) {
      return http.get(parsedUrl, headers: headers);
    }

    switch (method) {
      case EHttpMethods.get:
        return http.get(parsedUrl, headers: headers);
      case EHttpMethods.post:
        return http.post(parsedUrl, headers: headers, body: body);
      case EHttpMethods.put:
        return http.put(parsedUrl, headers: headers, body: body);
      case EHttpMethods.patch:
        return http.put(parsedUrl, headers: headers, body: body);
      default:
        throw UnsupportedError("Unsupported!");
    }
  }
}
