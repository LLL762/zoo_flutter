import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoo_flutter/src/features/nav/presentation/drop_dow_menu_item.dart';

class PopUpNavMenu extends StatelessWidget {
  static List<DropDownNavMenuItem> buildItems(BuildContext context) {
    return [
      DropDownNavMenuItem(
          text: "Home", icon: Icons.home, onPressed: () => context.go("/")),
      const DropDownNavMenuItem(text: "Zone", icon: Icons.map),
      const DropDownNavMenuItem(text: "Help", icon: Icons.help),
      const DropDownNavMenuItem(text: "Settings", icon: Icons.settings),
    ];
  }

  static wrapItems(BuildContext context) {
    final items = buildItems(context);
    return items.map((item) => PopupMenuItem(child: item)).toList();
  }

  const PopUpNavMenu({super.key});

  buildItem(String text, IconData icon, [void Function()? onClick]) {
    return TextButton(
        onPressed: onClick ?? () => {},
        child: Wrap(
          children: [Icon(icon), Text(text)],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(size: 32, color: Colors.white, Icons.menu),
          Text(style: TextStyle(color: Colors.white), "menu")
        ],
      ),
      itemBuilder: (BuildContext context) => wrapItems(context),
    );
  }
}
