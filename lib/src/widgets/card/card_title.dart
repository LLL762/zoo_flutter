import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String? title;

  const CardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 2.0,
                    color: Colors.black45)
              ]),
          textScaleFactor: 1.25,
          "$title"),
    );
  }
}
