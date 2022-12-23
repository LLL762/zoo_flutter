import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';

class LogInIcon extends StatelessWidget {
  final ILogInService logInservice;

  const LogInIcon({super.key, required this.logInservice});

  logInOnPressed(BuildContext context) {
    context.go("/log-in");
  }

  Widget buildLogInIcon(BuildContext context) {
    return IconButton(
        onPressed: logInOnPressed(context), icon: const Icon(Icons.login));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
