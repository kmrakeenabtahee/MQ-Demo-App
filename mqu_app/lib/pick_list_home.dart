import 'package:flutter/material.dart';
import 'package:mqu_app/boost_of_caffeine.dart';

class PickList extends StatefulWidget {
  const PickList({super.key});

  @override
  _PickListState createState() => _PickListState();
}

class _PickListState extends State<PickList> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 47,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        value: _selectedItem,
        underline: const SizedBox(), // Removes the underline
        isExpanded: true,
        hint: Text(
          'Pick from list',
          style: TextStyle(
            color: Colors.black.withOpacity(0.49),
            fontSize: 24,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
        items: <String>[
          'Find Your Service',
          'Book My Parking',
          'Boost of Caffeine',
          'AskMQ',
          'Book My Locker'
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.49),
                fontSize: 24,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          _navigateToPage(newValue);
        },
      ),
    );
  }

  void _navigateToPage(String? newValue) {
    if (newValue != null) {
      switch (newValue) {
        case 'Find Your Service':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BoostOfCaffeinePage()),
          );
          break;
        case 'Book My Parking':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BoostOfCaffeinePage()),
          );
          break;
        case 'Boost of Caffeine':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BoostOfCaffeinePage()),
          );
          break;
        case 'AskMQ':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BoostOfCaffeinePage()),
          );
          break;
        case 'Book My Locker':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BoostOfCaffeinePage()),
          );
          break;
        default:
          break;
      }
    }
  }
}
