import 'package:flutter/material.dart';
import 'cart.dart';

class OrderScreen extends StatefulWidget {
  final String cafeName;
  const OrderScreen({
    super.key,
    required this.cafeName,
  });

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final List<String> popularItems = [
    'Latte',
    'Red Bull 250 ml',
    'Cappuccino',
    'Mocha',
    'Croissant'
  ];
  final List<String> fullMenuItems = [
    'Cappuccino',
    'Croissant',
    'Latte',
    'Espresso',
    'Croissant',
    'Red Bull 500ml',
    'Red Bull 250 ml',
    'Monster',
    'Pureau 500ml',
    'Mt. Franklin 500ml Still',
    'Mt. Franklin 500ml Sparkling Lemon',
    'Bagel',
    'Mocha'
  ];

  final Map<String, int> order = {};

  final Map<String, double> itemPrices = {
    'Latte': 5.50,
    'Red Bull 250 ml': 2.00,
    'Cappuccino': 3.50,
    'Mocha': 4.00,
    'Croissant': 2.00,
    'Red Bull 500ml': 3.00,
    'Monster': 3.50,
    'Pureau 500ml': 1.50,
    'Mt. Franklin 500ml Still': 1.50,
    'Mt. Franklin 500ml Sparkling Lemon': 1.50,
    'Bagel': 2.50,
    'Espresso': 2.00,
  };

  String filter = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              color: const Color(0xFFD9D9D9),
            ),
          ),
          Positioned(
            top: screenHeight * 0.03,
            left: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.1,
              child: SingleChildScrollView(
                // Wrap the Row in SingleChildScrollView
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, size: 40),
                    ),
                    SizedBox(
                      width: screenWidth * 0.20,
                    ),
                    const Text(
                      'ESC Cafe',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.06,
                    ),
                    Image.asset(
                      'assets/esc.png',
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 177, 175, 175)
                                    .withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 4.0,
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  filter = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (order.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Cart is Empty'),
                                      content: const Text(
                                          'Your cart is currently empty.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(
                                      cafeName: widget.cafeName,
                                      order: order,
                                      itemPrices: itemPrices,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.shopping_cart),
                                SizedBox(width: 8),
                                Text('View Cart'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      if (filter.isEmpty)
                        _buildSection('Popular', popularItems),
                      _buildSection('Full Menu', fullMenuItems),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    final filteredItems = items
        .where((item) => item.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    return filteredItems.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 177, 175, 175)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return _buildListItem(item);
                    },
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildListItem(String item) {
    int quantity = order[item] ?? 0;
    double originalPrice = itemPrices[item] ?? 0.0;
    double totalPrice = originalPrice * quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // Wrap the Row in Expanded
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    iconSize: 35,
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (order[item] != null && order[item]! > 0) {
                          order[item] = order[item]! - 1;
                          if (order[item] == 0) {
                            order.remove(item);
                          }
                        }
                      });
                    },
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    iconSize: 35,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        order[item] = (order[item] ?? 0) + 1;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Price: \$${originalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
