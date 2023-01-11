import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:touchable/touchable.dart';
import 'package:zoo_flutter/src/features/content/zone/model/zoo_map_model.dart';

class EnclosureItemPainter extends CustomPainter {
  final List<String> svgPaths;
  final BuildContext context;
  final ZooMapChangeNotifier zooMapChangeNotifier;

  EnclosureItemPainter(this.svgPaths, this.context, this.zooMapChangeNotifier);

  @override
  bool shouldRepaint(EnclosureItemPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var touchyCanvas = TouchyCanvas(context, canvas);

    var xScale = size.width / 1229 - 0.005;
    var yScale = size.height / 597 - 0.005;
    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(xScale, yScale);
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    for (String svgPath in svgPaths) {
      final path = parseSvgPath(svgPath);
      paint.color = Colors.white30;

      if (zooMapChangeNotifier.selectedEnclosure?.path == svgPath) {
        paint.color = Colors.black;
      }

      touchyCanvas.drawPath(path.transform(matrix4.storage), paint,
          onTapDown: (details) {
        zooMapChangeNotifier.selectedEnclosure =
            EnclosureMapArea("45", svgPath);
      });
    }
  }
}
