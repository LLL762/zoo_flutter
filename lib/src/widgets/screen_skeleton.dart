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
    const headerHeight = ScreenConfigs.headerHeight;

    return Container(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  child: AppNavBar(logInService: logInService)),
              Padding(
                  padding: const EdgeInsets.only(top: headerHeight),
                  child: body)
            ],
          ),
        ),
      ),
    );
  }
}
