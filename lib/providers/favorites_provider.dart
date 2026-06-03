import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favorites = {};

  Set<String> get favorites => Set.unmodifiable(_favorites);

  FavoritesProvider() {
    _loadFavorites();
  }

  bool isFavorite(String mushafId) => _favorites.contains(mushafId);

  void toggleFavorite(String mushafId) {
    if (_favorites.contains(mushafId)) {
      _favorites.remove(mushafId);
    } else {
      _favorites.add(mushafId);
    }
    _saveFavorites();
    notifyListeners();
  }

  void addFavorite(String mushafId) {
    _favorites.add(mushafId);
    _saveFavorites();
    notifyListeners();
  }

  void removeFavorite(String mushafId) {
    _favorites.remove(mushafId);
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/favorites.json');
      if (await file.exists()) {
        final list = jsonDecode(await file.readAsString()) as List;
        _favorites.clear();
        _favorites.addAll(list.cast<String>());
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> _saveFavorites() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/favorites.json');
      await file.writeAsString(jsonEncode(_favorites.toList()));
    } catch (_) {}
  }
}
