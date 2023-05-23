import 'package:flutter/material.dart';

class PaymentMethodListView extends StatelessWidget {
  final List<String> paymentMethods = ["Moncash", "credit Card"];

  PaymentMethodListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detay peye'),
        ),
        body: ListView.builder(
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            final paymentMethod = paymentMethods[index];
            return ListTile(
              title: Text(paymentMethod),
              // Add onTap functionality here
              onTap: () {
                // Perform actions when a payment method is tapped
                // For example, navigate to payment details screen
              },
            );
          },
        ));
  }
}
