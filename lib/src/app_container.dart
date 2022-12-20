import 'package:flutter/material.dart';

import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';

class AppContainer extends InheritedWidget {
  final ILogInService logInService;

  const AppContainer(
      {Key? key, required Widget child, required this.logInService})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static AppContainer? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppContainer>();
}
