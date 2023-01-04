// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _preferDark;
  String? _fontName;

  bool get preferDark => _preferDark;
  String? get fontName => _fontName;

  set preferDark(bool preferDark) {
    _preferDark = preferDark;
    notifyListeners();
  }

  set fontName(String? fontName) {
    _fontName = fontName;
    notifyListeners();
  }

  ThemeModel({bool? preferDark, String? fontName})
      : _preferDark = preferDark ?? false,
        _fontName = fontName;

  ThemeModel copyWith({
    bool? preferDark,
    String? fontName,
  }) {
    return ThemeModel(
      preferDark: preferDark ?? _preferDark,
      fontName: fontName ?? _fontName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'preferDark': _preferDark,
      'fontName': _fontName,
    };
  }

  toThemeData(BuildContext context) {
    return ThemeData(
        fontFamily: fontName ?? "OpenDyslexicMono",
        brightness: preferDark ? Brightness.dark : null);
  }

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      preferDark: map['preferDark'] as bool,
      fontName: map['fontName'] != null ? map['fontName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeModel.fromJson(String source) =>
      ThemeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ThemeModel(preferDark: $_preferDark, fontName: $_fontName)';

  @override
  bool operator ==(covariant ThemeModel other) {
    if (identical(this, other)) return true;

    return other._preferDark == _preferDark && other._fontName == _fontName;
  }

  @override
  int get hashCode => _preferDark.hashCode ^ _fontName.hashCode;
}
