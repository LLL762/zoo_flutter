import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoo_flutter/main.dart';
import 'package:zoo_flutter/src/configs/screen_configs.dart';
import 'package:zoo_flutter/src/features/authentication/model/log_in_status.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/nav/presentation/preferences/preferences_menu.dart';
import 'package:zoo_flutter/src/widgets/button/default_btn.dart';

class PopUpNavMenu extends StatelessWidget {
  final ILogInService logInService = ILogInService("");

  static List<PopupMenuItem> buildItems(
      BuildContext context, LogInStatus? logInStatus) {
    final List<PopupMenuItem> output = [
      buildItem("Home", Icons.home, () => context.go("/")),
      buildItem("Zone", Icons.map),
    ];

    if (logInStatus != null && logInStatus != LogInStatus.logOut) {
      output.add(buildItem("Tasks", Icons.task, () => context.go("/tasks")));
    }

    output.add(buildSettings());
    output.add(buildItem("Help", Icons.help));

    return output;
  }

  PopUpNavMenu({super.key});

  static buildSettings() {
    return PopupMenuItem(
        child: PreferenceMenu(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: const [Icon(Icons.settings), Text("settings")],
      ),
    ));
  }

  static buildItem(String text, IconData icon, [void Function()? onTap]) {
    return PopupMenuItem(
      onTap: onTap,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [Icon(icon), Text(text)],
      ),
    );
  }

  buildFutureItems(BuildContext context, AsyncSnapshot<LogInStatus> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }

    if (snapshot.connectionState == ConnectionState.done) {
      return buildItems(context, snapshot.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loginService.getLogInStatus(),
      builder: (context, snapshot) {
        return PopupMenuButton(
          shape: DefaultBtn.shape,
          offset: const Offset(0, ScreenConfigs.headerHeight),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: const [
                Icon(size: 32, color: Colors.white, Icons.menu),
                Text(style: TextStyle(color: Colors.white), "menu")
              ],
            ),
          ),
          itemBuilder: (BuildContext context) {
            return buildFutureItems(context, snapshot);
          },
        );
      },
    );
  }
}
