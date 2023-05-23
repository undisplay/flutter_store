import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:store/class/ProductItem.dart';

import '../Provider/CartProvider.dart';
import '../Provider/FavoriteProvider.dart';
import '../class/Category.dart';
import '../class/Product.dart';
import 'CategoryScreen.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late List<Category> _categories = [];
  late List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/categories');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        final categories = data.map((item) => Category.fromJson(item)).toList();

        setState(() {
          _categories = categories;
        });
      } else {
        // Handle error response here
        print('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any network or API-related errors here
      print('Error: $error');
    }
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/products');

    // try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final products = data.map((item) => Product.fromJson(item)).toList();

      setState(() {
        _products = products;
      });
    } else {
      // Handle error response here
      print('Failed to fetch products: ${response.statusCode}');
    }
    // } catch (error) {
    //   // Handle any network or API-related errors here
    //   print('Error: $error');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lis pwodui'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Kategori yo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(category: category),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Chip(
                        label: Text(category.name),
                        avatar: CircleAvatar(
                          backgroundImage: NetworkImage(category.image),
                        ),
                      ),
                    ));
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pi bon pwodui yo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Consumer2<CartProvider, FavoriteProvider>(
              builder: (context, cartProvider, favoriteProvider, _) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductItem(
                  product: product,
                  cartProvider: cartProvider,
                  favoriteProvider: favoriteProvider,
                );
              },
            );
          }))
        ],
      ),
    );
  }
}
