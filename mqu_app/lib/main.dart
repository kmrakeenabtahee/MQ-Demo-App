import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'boost_of_caffeine.dart';
import 'package:mqu_app/cafe_orders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  try {
    // Initialize Firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (error) {
    // Handle error if order submission fails
    print('Error submitting order: $error');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MQU Coffee Order',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/boost': (context) => const BoostOfCaffeinePage(),
        '/home': (context) => const HomeScreen(),
        '/cafeOrders': (context) => const CafeOrdersPage(),
      },
    );
  }
}
