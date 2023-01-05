import 'package:http/http.dart' as http;
import 'package:zoo_flutter/src/features/authentication/model/log_in_status.dart';
import 'package:zoo_flutter/src/features/authentication/services/log_in_service.dart';

abstract class ILogInService {
  static ILogInService? _instance;

  factory ILogInService(String profile) {
    _instance ??= const LogInService();

    return _instance!;
  }

  Future<http.Response> logIn(logInReq);

  Future<http.Response> refreshTokens();

  Future<LogInStatus> getLogInStatus();

  Future<String?> getBearerToken();

  Future<String?> getRefreshToken();

  Future<String?> getBearerTokenExp();
}
