import 'package:flutter/material.dart';

class ZooMapChangeNotifier extends ChangeNotifier {
  EnclosureMapArea? _selectedEnclosure;

  EnclosureMapArea? get selectedEnclosure => _selectedEnclosure;

  set selectedEnclosure(EnclosureMapArea? enclosureMapArea) {
    _selectedEnclosure = enclosureMapArea;
    notifyListeners();
  }
}

class EnclosureMapArea {
  final String id;
  final String path;

  EnclosureMapArea(this.id, this.path);
}
