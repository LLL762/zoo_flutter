// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zoo_flutter/src/features/nav/preferences/config/preferences_config.dart';
import 'package:zoo_flutter/src/features/nav/preferences/model/theme_model.dart';
import 'package:zoo_flutter/src/features/nav/preferences/service/i_preference_service.dart';

class PreferenceMenu extends StatefulWidget {
  final Widget child;
  const PreferenceMenu({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<PreferenceMenu> createState() => _PreferenceMenuState();
}

class _PreferenceMenuState extends State<PreferenceMenu> {
  final preferenceService = IPreferenceService.factory();

  buildLightDarkSwitch() {
    return PopupMenuItem(
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
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
        },
      ),
    );
  }

  buildFontsDropDown() {
    final items = PreferencesConfig.fonts.fontNames
        .map((name) => DropdownMenuItem(value: name, child: Text(name)))
        .toList();
    items.add(const DropdownMenuItem(value: "Roboto", child: Text("Default")));

    return PopupMenuItem(
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return DropdownButton<String>(
              value: themeModel.fontName,
              items: items,
              onChanged: ((value) {
                themeModel.fontName = value;
                preferenceService.setTheme(themeModel);
              }));
        },
      ),
    );
  }

  List<PopupMenuItem> buildItems() {
    return [
      buildLightDarkSwitch(),
      buildFontsDropDown(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: widget.child,
        itemBuilder: (_) {
          return buildItems();
        });
  }
}
