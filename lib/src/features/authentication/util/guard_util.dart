import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/authentication/util/i_guard_util.dart';

import '../model/log_in_status.dart';

class GuardUtil implements IGuardUtil {
  final ILogInService loginService = ILogInService("");

  @override
  needAuth() async {
    final logInStatus = await loginService.getLogInStatus();

    if (logInStatus != LogInStatus.logIn &&
        logInStatus != LogInStatus.needRefresh) {
      return '/';
    }

    return null;
  }
}
