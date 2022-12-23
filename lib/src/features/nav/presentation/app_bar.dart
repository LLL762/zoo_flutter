import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';

class AppNavBar extends StatelessWidget {
  final ILogInService logInService;

  const AppNavBar({super.key, required this.logInService});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Text("lorenej  enjkneerbfbnjkd"));
  }
}
