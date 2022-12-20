import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/authentication/presentation/login_form.dart';

class LoginPage {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(builder: (context) => const LoginForm());
  }
}
