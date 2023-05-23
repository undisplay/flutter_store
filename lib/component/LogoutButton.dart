import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/LoginState.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        // Logout action
        loginState.logout();
      },
      child: const Text('Dekonekte'),
    );
  }
}
