import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/class/CartItem.dart';

import '../Provider/CartProvider.dart';
import '../Provider/LoginState.dart';
import '../class/cartItem.dart' as CustomCartItem;
import 'Login.dart';
import 'PaymentMethod.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final loginState = Provider.of<LoginState>(context, listen: true);
    final List<CartItem> cartItems = cartProvider.cartItems;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Cart'),
      // ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Panye a vid.'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  leading: Image.network(cartItem.product.images[0]),
                  title: Text(cartItem.product.title),
                  subtitle: Text(
                      'Pri: \$${cartItem.product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cartProvider.removeFromCart(cartItem);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (!loginState.isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodListView(),
                    ),
                  );
                }
              },
              child: const Text('Peye'),
            ),
          ],
        ),
      ),
    );
  }
}
