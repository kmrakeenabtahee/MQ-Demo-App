import 'package:flutter/material.dart';
import 'package:mqu_app/home_screen.dart';
import 'package:mqu_app/order_screen.dart';
import 'package:mqu_app/cafe_orders.dart';

class BoostOfCaffeinePage extends StatefulWidget {
  const BoostOfCaffeinePage({super.key});

  @override
  BoostOfCaffeinePageState createState() => BoostOfCaffeinePageState();
}

class BoostOfCaffeinePageState extends State<BoostOfCaffeinePage> {
  String? _selectedCafe;
  String cafeName = '';

  // Cafe positions on the map (relative coordinates)
  final Map<String, Offset> cafePositions = {
    'ESC Cafe, RPD': const Offset(1.4, 0.595),
    'Cult Eatery, 25 WW': const Offset(0.767, 0.53),
    'Cult Eatery, 1CC': const Offset(0.934, 0.4375),
    'Cult Eatery, Arts Precint': const Offset(0.671, 0.612),
    'MQU Library Cafe': const Offset(0.91, 0.725),
  };

  late TransformationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFD9D9D9),
        child: Stack(
          children: [
            Positioned(
              left: screenWidth * 0.023,
              top: screenHeight * 0.36,
              child: SizedBox(
                width: screenWidth * 0.95,
                height: screenHeight * 0.058,
                child: DropdownButtonFormField<String>(
                  key: const Key('dropdown_field'),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(),
                    hintText: "Choose your cafe",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  value: _selectedCafe,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCafe = newValue;
                    });
                    cafeName = _selectedCafe!;
                  },
                  items: <String>[
                    'Choose your cafe',
                    'ESC Cafe, RPD',
                    'Cult Eatery, 25 WW',
                    'Cult Eatery, 1CC',
                    'Cult Eatery, Arts Precint',
                    'MQU Library Cafe'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (_selectedCafe != null &&
                _selectedCafe != 'Choose your cafe' &&
                cafePositions.containsKey(_selectedCafe!))
              Positioned(
                left: screenWidth * 0.055,
                top: screenHeight * 0.5,
                child: SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.33,
                  child: GestureDetector(
                    onScaleUpdate: (details) {},
                    onDoubleTap: () {
                      context.findRenderObject() as RenderBox;
                      final double previousScale =
                          _controller.value.getMaxScaleOnAxis();
                      if (previousScale > 1.0 || previousScale <= 1.0) {
                        // Zoom out
                        _controller.value = Matrix4.identity();
                      }
                    },
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRect(
                        child: Transform.scale(
                          scale: 1.0, // Initial scale
                          child: InteractiveViewer(
                            transformationController:
                                _controller, // Use _controller here
                            boundaryMargin:
                                const EdgeInsets.all(double.infinity),
                            minScale: 1.0,
                            maxScale: 6.0,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/map.png',
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                if (cafePositions.containsKey(_selectedCafe!))
                                  Positioned(
                                    left: cafePositions[_selectedCafe!]!.dx *
                                            screenWidth *
                                            0.5 -
                                        10,
                                    top: cafePositions[_selectedCafe!]!.dy *
                                            screenHeight *
                                            0.3 -
                                        10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (_selectedCafe != null &&
                _selectedCafe != 'Choose your cafe' &&
                cafePositions.containsKey(_selectedCafe!))
              Positioned(
                left: screenWidth * 0.06,
                top: screenHeight * 0.44,
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: const Text(
                    'Try me!!! Pinch me out and in to zoom in and out. Alternatively, double tap to zoom out from zoomed in state or recenter the map.',
                    style: TextStyle(fontSize: 13, fontFamily: 'Work Sans'),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            if (_selectedCafe != null &&
                _selectedCafe != 'Choose your cafe' &&
                cafePositions.containsKey(_selectedCafe!))
              Positioned(
                left: screenWidth * 0.4,
                bottom: screenHeight * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderScreen(
                                cafeName: cafeName,
                              )),
                    );
                  },
                  child: const Text('Confirm'),
                ),
              ),
            Positioned(
              left: screenWidth * 0.25,
              top: screenHeight * 0.08,
              child: Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/mqu.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.75,
              top: screenHeight * 0.15,
              child: Container(
                width: screenWidth * 0.188,
                height: screenWidth * 0.188,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/home.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.023,
              top: screenHeight * 0.13,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CafeOrdersPage()), // Navigate to order screen
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth * 0.292,
                      height: screenHeight * 0.15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/caffeine.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.37,
                      height: screenHeight * 0.35,
                      alignment: Alignment.center,
                      child: const Text(
                        'Your Order History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
