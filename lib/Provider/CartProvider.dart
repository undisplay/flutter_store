import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../class/CartItem.dart';
import '../class/Product.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  late SharedPreferences _prefs;

  List<CartItem> get cartItems => _cartItems;

  int get cartItemCount => _cartItems.length;

  CartProvider() {
    init();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
    final cartItemsJson = _prefs.getString('cartItems');
    if (cartItemsJson != null) {
      final List<dynamic> cartItemsData = jsonDecode(cartItemsJson);
      _cartItems =
          cartItemsData.map((itemData) => CartItem.fromJson(itemData)).toList();
    }
  }

  double get totalPrice {
    double total = 0.0;
    _cartItems.forEach((item) {
      total += item.quantity * item.product.price;
    });
    return total;
  }

  void saveCartItems() {
    final List<dynamic> cartItemsData =
        _cartItems.map((item) => item.toJson()).toList();
    final cartItemsJson = jsonEncode(cartItemsData);
    _prefs.setString('cartItems', cartItemsJson);
  }

  void addToCart(Product product) {
    // // Check if the product is already in the cart
    // CartItem? existingCartItem = _cartItems.firstWhere(
    //   (item) => item.product.id == product.id,
    // );

    // // ignore: unnecessary_null_comparison
    // if (existingCartItem != null) {
    //   // Increase the quantity if the product is already in the cart
    //   existingCartItem.quantity += 1;
    // } else {
    //   // Add a new cart item if the product is not in the cart
    _cartItems.add(CartItem(product: product, quantity: 1));
    // }

    saveCartItems();
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    // Remove the cart item from the cart
    _cartItems.remove(cartItem);

    saveCartItems();
    notifyListeners();
  }
}
