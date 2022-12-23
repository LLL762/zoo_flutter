import 'package:flutter/material.dart';
import 'package:zoo_flutter/src/configs/screen_configs.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/nav/presentation/app_bar.dart';

class ScreenSkeleton extends StatelessWidget {
  final Widget body;
  final ILogInService logInService;

  const ScreenSkeleton(
      {super.key, required this.body, required this.logInService});

  @override
  Widget build(BuildContext context) {
    const maxWidth = ScreenConfigs.maxWidth;
    const minWidth = ScreenConfigs.minWidth;

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(maxWidth: maxWidth, minWidth: minWidth),
      child: ListView(children: [
        Stack(
          children: [
            Positioned(left: 0, child: AppNavBar(logInService: logInService)),
            Padding(padding: const EdgeInsets.only(top: 100), child: body)
          ],
        ),
      ]),
    ));
  }
}
