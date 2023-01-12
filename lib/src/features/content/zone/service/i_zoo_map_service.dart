import 'package:zoo_flutter/src/features/content/zone/model/zoo_map_model.dart';
import 'package:zoo_flutter/src/features/content/zone/service/zoo_map_service.dart';

abstract class IZooMapService {
  static IZooMapService? _instance;

  factory IZooMapService([String? profile]) {
    _instance ??= const ZooMapService();

    return _instance!;
  }

  Future<List<EnclosureMapArea>> getEnclosuresAreas();
}
