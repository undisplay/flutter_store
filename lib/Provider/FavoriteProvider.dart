import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../class/Product.dart';

class FavoriteProvider with ChangeNotifier {
  List<Product> _favoriteItems = [];
  late SharedPreferences _prefs;

  List<Product> get favoriteItems => _favoriteItems;

  FavoriteProvider() {
    init();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
    final favoriteItemsJson = _prefs.getString('favoriteItems');
    if (favoriteItemsJson != null) {
      final List<dynamic> favoriteItemsData = jsonDecode(favoriteItemsJson);
      _favoriteItems = favoriteItemsData
          .map((itemData) => Product.fromJson(itemData))
          .toList();
    }
  }

  void saveFavoriteItems() {
    final List<dynamic> favoriteItemsData =
        _favoriteItems.map((item) => item.toJson()).toList();
    final favoriteItemsJson = jsonEncode(favoriteItemsData);
    _prefs.setString('favoriteItems', favoriteItemsJson);
  }

  bool isFavorite(Product product) {
    return _favoriteItems.any((item) => item.id == product.id);
  }

  void toggleFavorite(Product product) {
    final isCurrentlyFavorite = isFavorite(product);
    if (isCurrentlyFavorite) {
      _favoriteItems.removeWhere((item) => item.id == product.id);
    } else {
      _favoriteItems.add(product);
    }

    saveFavoriteItems();
    notifyListeners();
  }
}
