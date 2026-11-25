import 'package:flutter/material.dart';

class SeedColorOption {
  const SeedColorOption(this.label, this.color);

  final String label;
  final Color color;
}

const List<SeedColorOption> kSeedColorOptions = <SeedColorOption>[
  SeedColorOption('M3 Baseline Purple', Color(0xFF6750A4)),
  SeedColorOption('iOS System Blue', Color(0xFF007AFF)),
  SeedColorOption('Ocean Teal', Color(0xFF006A6A)),
  SeedColorOption('Emerald Green', Color(0xFF1B6D3B)),
  SeedColorOption('Coral Red', Color(0xFFB3261E)),
  SeedColorOption('Amber Gold', Color(0xFF8C5000)),
  SeedColorOption('Rose Pink', Color(0xFF984061)),
  SeedColorOption('Slate Indigo', Color(0xFF3F5AA9)),
];

class AppThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  SeedColorOption _seedOption = kSeedColorOptions.first;
  DynamicSchemeVariant _schemeVariant = DynamicSchemeVariant.tonalSpot;
  TargetPlatform? _platformOverride;
  double _textScale = 1.0;
  bool _useBouncingScrollOnAll = false;

  ThemeMode get themeMode => _themeMode;
  SeedColorOption get seedOption => _seedOption;
  DynamicSchemeVariant get schemeVariant => _schemeVariant;
  TargetPlatform? get platformOverride => _platformOverride;
  double get textScale => _textScale;
  bool get useBouncingScrollOnAll => _useBouncingScrollOnAll;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void setSeedOption(SeedColorOption option) {
    if (_seedOption.color == option.color) return;
    _seedOption = option;
    notifyListeners();
  }

  void setSchemeVariant(DynamicSchemeVariant variant) {
    if (_schemeVariant == variant) return;
    _schemeVariant = variant;
    notifyListeners();
  }

  void setPlatformOverride(TargetPlatform? platform) {
    if (_platformOverride == platform) return;
    _platformOverride = platform;
    notifyListeners();
  }

  void setTextScale(double scale) {
    if ((_textScale - scale).abs() < 0.01) return;
    _textScale = scale;
    notifyListeners();
  }

  void setUseBouncingScrollOnAll(bool value) {
    if (_useBouncingScrollOnAll == value) return;
    _useBouncingScrollOnAll = value;
    notifyListeners();
  }

  ThemeData buildTheme(Brightness brightness) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _seedOption.color,
      brightness: brightness,
      dynamicSchemeVariant: _schemeVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      platform: _platformOverride,
      visualDensity: VisualDensity.standard,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
      ),
    );
  }
}
