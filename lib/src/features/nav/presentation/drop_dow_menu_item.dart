import 'package:flutter/material.dart';

class DropDownNavMenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const DropDownNavMenuItem({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed ?? () => {},
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [Icon(icon), Text(text)],
        ));
  }
}
