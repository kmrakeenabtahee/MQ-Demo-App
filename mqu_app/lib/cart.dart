import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqu_app/home_screen.dart';
import 'card_payment.dart';
import 'boost_of_caffeine.dart';
import 'firebase_options.dart';

class CartScreen extends StatefulWidget {
  final Map<String, int> order;
  final Map<String, double> itemPrices;
  final String cafeName;

  const CartScreen({
    super.key,
    required this.order,
    required this.itemPrices,
    required this.cafeName,
  });

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  late double grandTotal;

  @override
  void initState() {
    super.initState();
    _calculateGrandTotal();
  }

  void _calculateGrandTotal() {
    grandTotal = 0;
    widget.order.forEach((item, quantity) {
      grandTotal += widget.itemPrices[item]! * quantity;
    });
  }

  Future<void> _submitOrder() async {
    try {
      // Initialize Firebase
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      // Create a new order document in Firestore
      await FirebaseFirestore.instance.collection('orders').add({
        'cafeName': widget.cafeName, // Add cafeName field
        'order': widget.order,
        'totalAmount': grandTotal,
        'timestamp': Timestamp.now(),
      });

      // Clear the cart after placing the order
      // You can implement your logic here to clear the cart
      // For example:
      // cart.clear();

      // Navigate to a confirmation screen or perform any other actions
      // after the order has been submitted successfully
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OrderConfirmationScreen(
                cafeName: widget.cafeName,
                order: widget.order,
                total: grandTotal,
                itemPrices: widget.itemPrices)),
      );
    } catch (error) {
      // Handle error if order submission fails
      print('Error submitting order: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 40),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.325),
                const Text(
                  'Cart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: widget.order.length,
                itemBuilder: (context, index) {
                  final item = widget.order.keys.elementAt(index);
                  final quantity = widget.order[item]!;
                  final price = widget.itemPrices[item]!;
                  final total = price * quantity;
                  return ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Quantity: $quantity'),
                    trailing: Text('\$${total.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Grand Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shadowColor: Colors.grey,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Pay at Counter'),
                          onTap: () {
                            // Handle Pay at Counter option
                            _submitOrder();
                          },
                        ),
                        ListTile(
                          title: const Text('Card'),
                          onTap: () {
                            // Handle Card option
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardPaymentScreen(
                                  cafeName: widget.cafeName,
                                  order: widget.order,
                                  total: grandTotal,
                                  itemPrices: widget.itemPrices,
                                  submitOrder: _submitOrder,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Apple/Google Pay'),
                          onTap: () {
                            // Handle Apple/Google Pay option
                            _submitOrder();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Text(
              'Choose Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        ],
      ),
    );
  }
}

class OrderConfirmationScreen extends StatelessWidget {
  final Map<String, int> order;
  final Map<String, double> itemPrices;
  final double total;
  final String cafeName;

  const OrderConfirmationScreen({
    super.key,
    required this.cafeName,
    required this.order,
    required this.total,
    required this.itemPrices,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'Order Confirmation',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                IconButton(
                  icon: const ImageIcon(
                    AssetImage('home.png'), // Use asset image
                    size: 36, // Adjust size as needed
                    color: Colors.black, // Adjust color as needed
                  ),
                  onPressed: () {
                    // Navigate to Home screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Items Ordered:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: order.length,
                      itemBuilder: (context, index) {
                        final itemName = order.keys.elementAt(index);
                        final quantity = order[itemName];
                        final price = itemPrices[itemName] ?? 0.0;
                        return ListTile(
                          title: Text('$itemName x$quantity (\$$price ea)'),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    thickness: 2.0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$$total',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shadowColor: Colors.grey,
              ),
              onPressed: () {
                // Navigate to BoostOfCaffeine screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BoostOfCaffeinePage()),
                  (route) => false,
                );
              },
              child: const Text('Continue Shopping'),
            ),
          ),
        ],
      ),
    );
  }
}
