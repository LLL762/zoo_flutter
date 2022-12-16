import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ILogInService {
  ILogInService(BuildContext context);

  Future<http.Response> logIn(logInReq);
}
