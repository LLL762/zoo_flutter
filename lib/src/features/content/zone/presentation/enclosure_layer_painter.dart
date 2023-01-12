import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:touchable/touchable.dart';
import 'package:zoo_flutter/src/features/content/zone/model/zoo_map_model.dart';

class EnclosureLayerPainter extends CustomPainter {
  final List<EnclosureMapArea> enclosures;
  final BuildContext context;
  final ZooMapChangeNotifier zooMapChangeNotifier;
  final Paint defaultPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.transparent;
  final Paint selectedPaintOutline = Paint()
    ..color = Colors.yellow
    ..style = PaintingStyle.stroke;
  final Paint selectedPaintFill = Paint()
    ..color = const Color.fromARGB(71, 33, 149, 243)
    ..style = PaintingStyle.fill;

  EnclosureLayerPainter(
      this.enclosures, this.context, this.zooMapChangeNotifier);

  @override
  bool shouldRepaint(EnclosureLayerPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final touchyCanvas = TouchyCanvas(context, canvas);
    final xScale = size.width / 1229 - 0.005;
    final yScale = size.height / 597 - 0.005;
    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(xScale, yScale);

    for (EnclosureMapArea enclosure in enclosures) {
      final path = parseSvgPath(enclosure.path);

      final bool isSelected =
          zooMapChangeNotifier.selectedEnclosure?.path == enclosure.path;

      if (isSelected) {
        canvas.drawPath(
            dashPath(path,
                    dashArray: CircularIntervalList<double>([8, 16]),
                    dashOffset: DashOffset.percentage(0.005))
                .transform(matrix4.storage),
            selectedPaintOutline);
      }

      touchyCanvas.drawPath(path.transform(matrix4.storage),
          isSelected ? selectedPaintFill : defaultPaint, onTapDown: (details) {
        zooMapChangeNotifier.selectedEnclosure = enclosure;
        print(enclosure.id);
      });
    }
  }
}
