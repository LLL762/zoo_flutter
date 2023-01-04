import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo_flutter/src/features/nav/preferences/config/preferences_config.dart';
import 'package:zoo_flutter/src/features/nav/preferences/model/theme_model.dart';
import 'package:zoo_flutter/src/features/nav/preferences/service/i_preference_service.dart';

class PreferencesService extends ChangeNotifier implements IPreferenceService {
  static final themeKey = PreferencesConfig.storage.themeKey;

  @override
  getTheme() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final data = sharedPreferences.getString(themeKey);

      if (data == null || data.isEmpty) {
        return ThemeModel();
      }
      return ThemeModel.fromJson(data);
    } catch (e) {
      return ThemeModel();
    }
  }

  @override
  setTheme(ThemeModel themeModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString(themeKey, themeModel.toJson());
  }
}
