import 'package:flutter/material.dart';
import 'pick_list_home.dart';
import 'boost_of_caffeine.dart'; // Import your page for Boost of Caffeine
// Import your page for Book my Locker
// Import your page for Book my Parking

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
        child: Stack(
          children: [
            Positioned(
              left: 12.0,
              top: MediaQuery.of(context).size.height * 0.665,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.height * 0.141,
                decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
              ),
            ),
            // 'Welcome Back'
            Positioned(
              left: -11.0,
              top: MediaQuery.of(context).size.height * 0.2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1.076,
                height: MediaQuery.of(context).size.height * 0.11,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: 0.80, // 15% shrink
                      child: Image.asset(
                        'assets/Welcome_Back.png', // Replace with your actual image file name
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Text(
                      'Welcome Back! K',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.97),
                        fontSize: 35,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                        height: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: -20.0,
              top: -20.0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width *
                    1.5, // Set width to screen width
                child: Stack(
                  children: [
                    // Positioned for the Semicircle image
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.width * 0.01,
                      child: Transform(
                        transform: Matrix4.diagonal3Values(1.7, 1.1, 1.0),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/Semicircle.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Positioned for the text '(You)'
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.6,
                      top: MediaQuery.of(context).size.width * 0.1,
                      child: const SizedBox(
                        width: 194,
                        height: 95,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '(',
                                style: TextStyle(
                                  color: Color(0xFFA6192E),
                                  fontSize: 64,
                                  fontFamily: 'Bexley',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: 'YOU',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 64,
                                  fontFamily: 'Work Sans',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: ')',
                                style: TextStyle(
                                  color: Color(0xFFA6192E),
                                  fontSize: 64,
                                  fontFamily: 'Bexley',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.92,
                      top: MediaQuery.of(context).size.width * 0.08,
                      child: const SizedBox(
                        width: 47,
                        height: 32,
                        child: Text(
                          'us',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFA6192E),
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Besley',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.width * 0.08,
                      child: SizedBox(
                        width: 144,
                        height: 128,
                        child: Image.asset('assets/mqu.png', fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 'Find Your Service'
            Positioned(
              left: 30.0,
              top: MediaQuery.of(context).size.height * 0.330,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.307,
                height: MediaQuery.of(context).size.height * 0.1005,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Positioned for the Service image
                    Transform(
                      transform: Matrix4.diagonal3Values(1, 0.95, 1),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/Service.png',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    // Positioned for the text 'Find your Service'
                    const Text(
                      'Find your Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Besley',
                        fontWeight: FontWeight.w400,
                        height: -1.0000000595,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 'Book my Locker'
            Positioned(
              left: MediaQuery.of(context).size.width * 0.55,
              top: MediaQuery.of(context).size.height * 0.725,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BoostOfCaffeinePage()),
                  );
                },
                child: SizedBox(
                  width: 155,
                  height: 155,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Text 'Book my Locker'
                      const Text(
                        'Book my Locker',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w600,
                          height: -1.1,
                        ),
                      ),
                      // Positioned for the locker image
                      Transform.translate(
                        offset: const Offset(
                            0.0, -50.0), // Move the image 20 pixels higher
                        child: Transform(
                          transform: Matrix4.diagonal3Values(1, 1, 1),
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/locker.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 'Ask MQ'
            Positioned(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.725,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BoostOfCaffeinePage()),
                  );
                },
                child: const SizedBox(
                  width: 155,
                  height: 155,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 45,
                        top: 0.75,
                        child: Text(
                          'Ask MQ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Work Sans',
                            fontWeight: FontWeight.w600,
                            height: 18.5,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '\nAsk',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w800,
                                height: -2,
                              ),
                            ),
                            TextSpan(
                              text: 'MQ',
                              style: TextStyle(
                                color: Color(0xFFA6192E),
                                fontSize: 36,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 'Boost of Caffeine'
            Positioned(
              left: MediaQuery.of(context).size.width * 0.55,
              top: MediaQuery.of(context).size.height * 0.48,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BoostOfCaffeinePage()),
                  );
                },
                child: SizedBox(
                  width: 155,
                  height: 155,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Text 'Boost of Caffeine'
                      const Text(
                        'Boost of Caffeine',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w600,
                          height: -1.1,
                        ),
                      ),
                      // Positioned for the caffeine image
                      Transform.translate(
                        offset: const Offset(
                            0.0, -50.0), // Move the image 20 pixels higher
                        child: Transform(
                          transform: Matrix4.diagonal3Values(1, 1, 1),
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/caffeine.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 'Book my Parking'
            Positioned(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.48,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BoostOfCaffeinePage()),
                  );
                },
                child: SizedBox(
                  width: 155,
                  height: 155,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const Text(
                        'Book my Parking',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w600,
                          height: -1.1,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(
                            0.0, -50.0), // Move the image 50 pixels higher
                        child: Transform(
                          transform: Matrix4.diagonal3Values(1, 1, 1),
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/parking.png', // replace 'parking.png' with your actual image path
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 'Pick from list'
            Positioned(
              left: MediaQuery.of(context).size.width * 0.41,
              top: MediaQuery.of(context).size.height * 0.35,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.577,
                height: MediaQuery.of(context).size.height * 0.099,
                child: const Stack(
                  children: [
                    Positioned(child: PickList()),
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
