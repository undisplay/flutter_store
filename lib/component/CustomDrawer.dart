// ignore: file_names
import 'package:flutter/material.dart';

import '../screen/Login.dart';
import '../screen/ProductList.dart';
import 'LogoutButton.dart';

class CustomDrawer extends StatelessWidget {
  final bool isLoggedIn; // Flag to determine if the user is logged in or not
  final Map user;

  const CustomDrawer({
    super.key,
    required this.isLoggedIn,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          if (isLoggedIn) Chip(label: Text(user['email'])),
          ListTile(
            title: const Text('Lis pwodui'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductListPage(),
                ),
              );
            },
          ),
          isLoggedIn
              ? LogoutButton()
              : ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Konekte'),
                )
        ],
      ),
    ));
  }
}
