class PreferencesConfig {
  static const storage = Storage();
  static const fonts = FontsConfig();
}

class Storage {
  final themeKey = "theme";
  const Storage();
}

class FontsConfig {
  final fontNames = const ["OpenDyslexicMono"];

  const FontsConfig();
}
