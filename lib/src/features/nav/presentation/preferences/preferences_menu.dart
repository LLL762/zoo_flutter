// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zoo_flutter/src/features/nav/preferences/model/theme_model.dart';
import 'package:zoo_flutter/src/features/nav/preferences/service/i_preference_service.dart';

class PreferenceMenu extends StatefulWidget {
  const PreferenceMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<PreferenceMenu> createState() => _PreferenceMenuState();
}

class _PreferenceMenuState extends State<PreferenceMenu> {
  final preferenceService = IPreferenceService.factory();

  buildLightDarkSwitch(ThemeModel themeModel) {
    return Row(children: [
      const Icon(size: 22, Icons.sunny),
      Switch(
          value: themeModel.preferDark,
          onChanged: (bool value) {
            themeModel.preferDark = value;
            preferenceService.setTheme(themeModel);
          }),
      const Icon(size: 22, Icons.mode_night)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return buildLightDarkSwitch(themeModel);
      },
    );
  }
}
