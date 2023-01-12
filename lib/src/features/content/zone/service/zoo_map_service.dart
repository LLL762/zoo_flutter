import 'package:flutter/services.dart';
import 'package:xml/xml.dart';
import 'package:zoo_flutter/src/features/content/zone/config/zone_map_config.dart';
import 'package:zoo_flutter/src/features/content/zone/model/zoo_map_model.dart';
import 'package:zoo_flutter/src/features/content/zone/service/i_zoo_map_service.dart';

class ZooMapService implements IZooMapService {
  const ZooMapService();

  @override
  Future<List<EnclosureMapArea>> getEnclosuresAreas() async {
    final location = ZoneMapConfig.enclosures.loc;
    final generalString = await rootBundle.loadString(location);
    final document = XmlDocument.parse(generalString);
    return document
        .findAllElements('path')
        .map((e) => EnclosureMapArea(
            e.getAttribute('id').toString(), e.getAttribute('d').toString()))
        .toList();
  }
}
