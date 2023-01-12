import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';
import 'package:zoo_flutter/src/features/content/zone/model/zoo_map_model.dart';

import 'enclosure_layer_painter.dart';

class EnclosureLayer extends StatelessWidget {
  final Size svgSize;
  final List<EnclosureMapArea> enclosures;

  const EnclosureLayer(
      {super.key, required this.svgSize, required this.enclosures});

  @override
  Widget build(BuildContext context) {
    return Consumer<ZooMapChangeNotifier>(
      builder: (context, value, child) {
        return CanvasTouchDetector(
            gesturesToOverride: const [GestureType.onTapDown],
            builder: ((context) => CustomPaint(
                size: svgSize,
                painter: EnclosureLayerPainter(enclosures, context, value))));
      },
    );
  }
}
