import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _initialized = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveTheme();
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/app_settings.json');
      if (await file.exists()) {
        final json = jsonDecode(await file.readAsString());
        _isDarkMode = json['isDarkMode'] ?? false;
      }
    } catch (_) {}
    _initialized = true;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/app_settings.json');
      await file.writeAsString(jsonEncode({'isDarkMode': _isDarkMode}));
    } catch (_) {}
  }
}
