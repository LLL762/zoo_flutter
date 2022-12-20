import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/app_container.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ILogInService logInService;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    logInService = AppContainer.of(context)?.logInService as ILogInService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
