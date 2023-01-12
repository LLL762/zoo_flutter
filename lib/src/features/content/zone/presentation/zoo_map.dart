import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoo_flutter/src/configs/screen_configs.dart';
import 'package:zoo_flutter/src/features/content/zone/config/zone_map_config.dart';
import 'package:zoo_flutter/src/features/content/zone/model/zoo_map_model.dart';
import 'package:zoo_flutter/src/features/content/zone/presentation/enclosure_layer.dart';

class ZooMap extends StatelessWidget {
  final List<EnclosureMapArea> enclosures;

  const ZooMap({super.key, required this.enclosures});

  double calcImgWidth(double screenWidth) {
    return min(screenWidth - 10, ScreenConfigs.maxWidth - 10);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final svgWidth = calcImgWidth(screenWidth);
    final svgSize = Size(svgWidth, svgWidth * (1 / ZoneMapConfig.ratio));

    return Stack(
      children: [
        SvgPicture.asset(placeholderBuilder: (context) {
          return const CircularProgressIndicator();
        }, width: svgWidth, ZoneMapConfig.imgLoc),
        Positioned(
            child: EnclosureLayer(svgSize: svgSize, enclosures: enclosures))
      ],
    );
  }
}
