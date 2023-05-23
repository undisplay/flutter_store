import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../Provider/CartProvider.dart';
import '../Provider/FavoriteProvider.dart';
import '../class/Category.dart';
import '../class/Product.dart';
import '../class/ProductItem.dart';
import 'ProductDetail.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProductsByCategory(widget.category.id).then((List<Product> data) {
      setState(() {
        products = data;
      });
    }).catchError((error) {
      // Handle error
    });
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final url =
        'https://api.escuelajs.co/api/v1/categories/$categoryId/products';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch products for category');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kategory: ${widget.category.name}'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(productId: product.id),
                ),
              );
            },
            child: Consumer2<CartProvider, FavoriteProvider>(
              builder: (context, cartProvider, favoriteProvider, _) {
                return ProductItem(
                  product: product,
                  cartProvider: cartProvider,
                  favoriteProvider: favoriteProvider,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
