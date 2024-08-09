/// The `CafeOrdersPage` class in Dart represents a page displaying a user's order history from a cafe,
/// with each order shown in an expandable `OrderTile` widget.
library;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/// The `CafeOrdersPage` class in Dart represents a page displaying a user's order history from a cafe
/// with a list of orders fetched from Firestore and displayed in a ListView.
class CafeOrdersPage extends StatelessWidget {
  const CafeOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.03,
            left: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.1,
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 40),
                  ),
                  SizedBox(width: screenWidth * 0.10),
                  const Text(
                    'Your Order History',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'caffeine.png',
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.3,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: screenHeight * 0.13,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No orders found.'),
                  );
                }
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    final data = document.data() as Map<String, dynamic>;
                    final timestamp = (data['timestamp'] as Timestamp).toDate();
                    final time = DateFormat.jm().format(timestamp);
                    final cafeName = data['cafeName'];
                    final orderDetails = data['order'];
                    final total = data['totalAmount'];

                    return OrderTile(
                      timestamp: timestamp,
                      time: time,
                      cafeName: cafeName,
                      orderDetails: orderDetails,
                      total: total,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTile extends StatefulWidget {
  final DateTime timestamp;
  final String time;
  final String cafeName;
  final Map<dynamic, dynamic> orderDetails;
  final double total;

  const OrderTile({
    required this.timestamp,
    required this.time,
    required this.cafeName,
    required this.orderDetails,
    required this.total,
    super.key,
  });

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          'Date: ${DateFormat.yMd().format(widget.timestamp)} - Time: ${widget.time}',
        ),
        subtitle: Text('Cafe Name: ${widget.cafeName}'),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                ..._buildOrderItemList(widget.orderDetails, widget.total),
                const SizedBox(height: 12),
                Text(
                  'Total Amount: \$${widget.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
      ),
    );
  }

  List<Widget> _buildOrderItemList(Map<dynamic, dynamic> order, double total) {
    List<Widget> items = [];
    order.forEach((key, value) {
      items.add(
        Text(
          '$key x$value',
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.start,
        ),
      );
    });
    return items;
  }
}
