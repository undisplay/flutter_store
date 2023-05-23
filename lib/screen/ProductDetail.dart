// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:store/class/Category.dart';

import '../Provider/CartProvider.dart';
import '../Provider/FavoriteProvider.dart';
import '../class/Product.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Product product = Product(
      id: 0,
      title: "",
      price: 0,
      description: "",
      category: Category(id: 0, name: "", image: ""),
      images: []);

  @override
  void initState() {
    super.initState();
    fetchProductDetails(widget.productId).then((data) {
      setState(() {
        product = Product.fromJson(data);
      });
    }).catchError((error) {
      // Handle error
    });
  }

  Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
    final url = 'https://api.escuelajs.co/api/v1/products/$productId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to fetch product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    if (product.id == 0) {
      // Show loading indicator or placeholder
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    bool isFavorite = favoriteProvider.isFavorite(product);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detay pwodui'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.images[0]),
            const SizedBox(height: 16.0),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Pri: \$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Deskripsyon:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cartProvider.addToCart(product);
        },
        child: const Icon(Icons.add_shopping_cart),
      ),
      persistentFooterButtons: [
        IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          onPressed: () {
            favoriteProvider.toggleFavorite(product);
          },
        ),
      ],
    );
  }
}
