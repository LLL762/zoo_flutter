import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';

class LoginRoute {
  build(ILogInService logInService) {
    return GoRoute(
      path: 'log-in',
      builder: (BuildContext context, GoRouterState state) {
        return const Text("");
      },
    );
  }
}
