import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Provider/CartProvider.dart';
import '../Provider/FavoriteProvider.dart';
import '../screen/ProductDetail.dart';
import 'Product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final CartProvider cartProvider;
  final FavoriteProvider favoriteProvider;

  const ProductItem({
    required this.product,
    required this.cartProvider,
    required this.favoriteProvider,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = favoriteProvider.isFavorite(product);

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(productId: product.id),
            ),
          );
        },
        child: Card(
          child: Column(
            children: [
              Image.network(product.images[0]),
              Text(product.title),
              Text(product.price.toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      cartProvider.addToCart(product);
                    },
                    child: const Icon(Icons.add_shopping_cart),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      favoriteProvider.toggleFavorite(product);
                    },
                    child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
