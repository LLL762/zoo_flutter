class ZoneMapConfig {
  static const originalWidth = 1229.0;
  static const originalHeigth = 597.0;
  static const ratio = originalWidth / originalHeigth;
  static const imgLoc = "images/zone/zoo_map.svg";
  static const enclosures = EnclosureLayerConfigs();

  ZoneMapConfig._();
}

class EnclosureLayerConfigs {
  final loc = "images/zone/enclosure-layer.svg";

  const EnclosureLayerConfigs();
}
