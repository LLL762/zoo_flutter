import 'package:flutter/material.dart';

class DefaultBtn extends StatelessWidget {
  static final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(color: Colors.transparent));
  static const padding = EdgeInsets.all(12);

  final Widget child;
  final void Function()? onPressed;

  const DefaultBtn({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        elevation: 0,
        shape: shape,
      ),
      onPressed: onPressed ?? () => {},
      child: child,
    );
  }
}
