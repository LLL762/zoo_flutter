import 'package:zoo_flutter/src/features/authentication/util/guard_util.dart';

abstract class IGuardUtil {
  static IGuardUtil? _instance;

  factory IGuardUtil([String? profile]) {
    _instance ??= GuardUtil();
    return _instance!;
  }

  Future<String?> needAuth();
}
