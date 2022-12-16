import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:http/http.dart' as http;

class LogInService implements ILogInService {
  final logInUrl = "http://localhost:3000/api/login";
  final bearerPrefix = "Bearer ";
  final secureStorage = const FlutterSecureStorage();

  const LogInService();

  @override
  Future<http.Response> logIn(logInReq) async {
    final resp = await http.post(Uri.parse(logInUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(logInReq));

    if (resp.statusCode != 200) {
      return resp;
    }

    print(resp.headers);

    final bearerToken = resp.headers["authorization"];

    if (bearerToken != null) {
      DateTime bearerTokenExp = JwtDecoder.getExpirationDate(
          bearerToken.replaceFirst(bearerPrefix, ""));
      await secureStorage.write(key: "bearerToken", value: bearerToken);
      await secureStorage.write(
          key: "bearerTokenExp", value: bearerTokenExp.toString());
    }
    return resp;
  }
}
