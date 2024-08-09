import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cafe Name: ${order['cafeName']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Order Items:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildOrderItemList(order['order']),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Amount: \$${order['totalAmount'].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOrderItemList(Map<dynamic, dynamic> order) {
    List<Widget> items = [];
    order.forEach((key, value) {
      items.add(
        Text(
          '$key x$value',
          style: const TextStyle(fontSize: 14),
        ),
      );
    });
    return items;
  }
}
