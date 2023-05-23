import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Provider/CartProvider.dart';
import '../Provider/FavoriteProvider.dart';
import '../class/Product.dart';
import '../class/ProductItem.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final List<Product> favoriteItems = favoriteProvider.favoriteItems;

    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Favorites'),
        // ),
        body: favoriteItems.isEmpty
            ? const Center(
                child: Text('Pa gen favori.'),
              )
            : Consumer2<CartProvider, FavoriteProvider>(
                builder: (context, cartProvider, favoriteProvider, _) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: favoriteItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = favoriteItems[index];
                    return ProductItem(
                      product: product,
                      cartProvider: cartProvider,
                      favoriteProvider: favoriteProvider,
                    );
                  },
                );
              }));
  }
}
