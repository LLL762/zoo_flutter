import 'package:zoo_flutter/src/features/nav/preferences/model/theme_model.dart';
import 'package:zoo_flutter/src/features/nav/preferences/service/preferences_service.dart';

abstract class IPreferenceService {
  static IPreferenceService? _instance;

  static IPreferenceService factory({String? profile}) {
    _instance ??= PreferencesService();
    return _instance!;
  }

  Future<ThemeModel> getTheme();
  Future<void> setTheme(ThemeModel themeModel);
}
