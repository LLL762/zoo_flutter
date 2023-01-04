import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoo_flutter/src/configs/screen_configs.dart';
import 'package:zoo_flutter/src/widgets/button/default_btn.dart';

class PopUpNavMenu extends StatelessWidget {
  static List<PopupMenuItem> buildItems(BuildContext context) {
    return [
      buildItem("Home", Icons.home, () => context.go("/")),
      buildItem("Zone", Icons.map),
      buildItem("Help", Icons.help),
      buildItem("Settings", Icons.settings),
    ];
  }

  const PopUpNavMenu({super.key});

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

  @override
  Widget build(BuildContext context) {
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
      itemBuilder: (BuildContext context) => buildItems(context),
    );
  }
}
