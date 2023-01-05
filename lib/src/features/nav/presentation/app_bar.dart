import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoo_flutter/main.dart';
import 'package:zoo_flutter/src/configs/screen_configs.dart';
import 'package:zoo_flutter/src/features/authentication/model/log_in_status.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/nav/presentation/drop_down_menu.dart';
import 'package:zoo_flutter/src/features/nav/presentation/preferences/preferences_menu.dart';
import 'package:zoo_flutter/src/widgets/button/default_btn.dart';

class AppNavBar extends StatelessWidget {
  final ILogInService logInService;

  const AppNavBar({super.key, required this.logInService});

  buildIconBtn(String text, IconData icon, [void Function()? onPressed]) {
    return DefaultBtn(
      onPressed: onPressed,
      child: Column(
        children: [Icon(size: 32, icon), Text(text)],
      ),
    );
  }

  futureAuthIconBuilder(
      BuildContext context, AsyncSnapshot<LogInStatus> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }

    if (snapshot.connectionState == ConnectionState.done) {
      return snapshot.data == LogInStatus.logOut
          ? buildIconBtn("login", Icons.login)
          : buildIconBtn("profile", Icons.manage_accounts);
    }
  }

  buildIconsLeft(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLarge = mediaQuery.size.width >= ScreenConfigs.breakpoints.large;

    return Wrap(
        spacing: 2,
        alignment: WrapAlignment.center,
        children: isLarge
            ? [
                const PopUpNavMenu(),
                buildIconBtn("home", Icons.home),
                buildIconBtn("zones", Icons.map),
              ]
            : [const PopUpNavMenu()]);
  }

  buildIconsRight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMediumHigh =
        mediaQuery.size.width >= ScreenConfigs.breakpoints.large;
    final authIcon = FutureBuilder(
        future: loginService.getLogInStatus(),
        builder: (context, snapshot) =>
            futureAuthIconBuilder(context, snapshot));

    return Wrap(
        spacing: 2,
        children: isMediumHigh
            ? [
                PreferenceMenu(
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: const [
                          Icon(size: 32, Icons.settings),
                          Text("settings")
                        ],
                      )),
                ),
                buildIconBtn("help", Icons.help),
                authIcon,
              ]
            : [authIcon]);
  }

  buildTitle() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Text(style: TextStyle(fontSize: 35), "Sigil Zoo App"),
      Text("Zoo management tool")
    ]);
  }

  buildNav(BuildContext context) {
    const maxWidth = ScreenConfigs.maxWidth;
    const height = ScreenConfigs.headerHeight;
    final width = min(MediaQuery.of(context).size.width, maxWidth);

    return Container(
        padding: const EdgeInsets.all(5),
        width: width,
        color: Colors.blue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildIconsLeft(context),
            buildTitle(),
            buildIconsRight(context)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return buildNav(context);
  }
}
