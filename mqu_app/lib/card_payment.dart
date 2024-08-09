import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqu_app/cart.dart';
import 'package:logger/logger.dart';

class CardPaymentScreen extends StatefulWidget {
  final Map<String, int> order;
  final Map<String, double> itemPrices;
  final String cafeName;
  final double total;
  final Function() submitOrder;

  const CardPaymentScreen({
    super.key,
    required this.cafeName,
    required this.order,
    required this.total,
    required this.itemPrices,
    required this.submitOrder,
  });

  @override
  CardPaymentScreenState createState() => CardPaymentScreenState();
}

class CardPaymentScreenState extends State<CardPaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final Logger logger = Logger();
  String _cardCompany = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 40),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 20),
                  Icon(_getCardIcon(_cardCompany)),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Card Payment',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Card Number (16 Digits)',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 12,
                        top: 20,
                        right: 12,
                        bottom: 20,
                      ),
                      suffixStyle: const TextStyle(color: Colors.black),
                    ),
                    onChanged: (value) {
                      _detectCardCompany(value);
                      _formatCardNumber(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _cvvController,
              keyboardType: TextInputType.number,
              maxLength: 3,
              decoration: InputDecoration(
                labelText: 'CVV',
                counterText: '', // Hides the character counter
                suffixIcon: const Icon(Icons.lock),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.fromLTRB(
                    12, 20, 12, 20), // Adjust padding here
                suffixStyle: const TextStyle(color: Colors.black),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _expiryDateController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ExpiryDateTextInputFormatter(),
              ],
              decoration: InputDecoration(
                labelText: 'Expiry Date (MM/YY)',
                isDense: true,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.only(
                  left: 12,
                  top: 20,
                  right: 12,
                  bottom: 20,
                ),
                suffixStyle: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _processPayment();
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCardIcon(String cardCompany) {
    switch (cardCompany) {
      case 'Visa':
        return Icons.credit_card;
      case 'MasterCard':
        return Icons.credit_card;
      case 'Diners Club':
        return Icons.credit_card;
      case 'Discover':
        return Icons.credit_card;
      case 'JCB':
        return Icons.credit_card;
      case 'American Express':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  void _detectCardCompany(String value) {
    setState(() {
      if (value.length >= 4) {
        String firstFourDigits = value.substring(0, 4);
        if (firstFourDigits.startsWith('4')) {
          _cardCompany = 'Visa';
        } else if (firstFourDigits.startsWith('51') ||
            firstFourDigits.startsWith('52') ||
            firstFourDigits.startsWith('53') ||
            firstFourDigits.startsWith('54') ||
            firstFourDigits.startsWith('55')) {
          _cardCompany = 'MasterCard';
        } else if (firstFourDigits.startsWith('36') ||
            firstFourDigits.startsWith('38')) {
          _cardCompany = 'Diners Club';
        } else if (firstFourDigits.startsWith('6011') ||
            firstFourDigits.startsWith('65')) {
          _cardCompany = 'Discover';
        } else if (firstFourDigits.startsWith('35')) {
          _cardCompany = 'JCB';
        } else if (firstFourDigits.startsWith('34') ||
            firstFourDigits.startsWith('37')) {
          _cardCompany = 'American Express';
        }
      }
    });
  }

  void _formatCardNumber(String value) {
    String formattedValue = value.replaceAll(' ', ''); // Remove all spaces
    String updatedValue = '';

    // Format the card number with spaces after every 4 characters
    for (int i = 0; i < formattedValue.length; i++) {
      if (i > 0 && i % 4 == 0) {
        updatedValue += ' ';
      }
      if (i < 16) {
        updatedValue += formattedValue[i];
      }
    }

    // Update the text field
    _cardNumberController.value = TextEditingValue(
      text: updatedValue,
      selection: TextSelection.collapsed(offset: updatedValue.length),
    );
  }

  void _processPayment() {
    String cardNumber = _cardNumberController.text.replaceAll(' ', '');
    String cvv = _cvvController.text;
    String expiryDate = _expiryDateController.text;
    // Validate card number, CVV, and expiry date
    if (_validateCardNumber(cardNumber) &&
        _validateCVV(cvv) &&
        _validateExpiryDate(expiryDate)) {
      // Payment processing logic
      logger.d('Card Number: $cardNumber');
      logger.d('CVV: $cvv');
      logger.d('Expiry Date: $expiryDate');
      // After processing, navigate back
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(
            cafeName: widget.cafeName,
            order: widget.order,
            total: widget.total,
            itemPrices: widget.itemPrices,
          ),
        ),
      ).then((_) {
        // After the user is done with confirmation screen, submit the order
        widget.submitOrder();
      });
    } else {
      // Show error message if validation fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Invalid card details. Please check and try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool _validateCardNumber(String cardNumber) {
    String firstFourDigits = cardNumber.substring(0, 4);
    if (firstFourDigits.startsWith('4') ||
        firstFourDigits.startsWith('51') ||
        firstFourDigits.startsWith('52') ||
        firstFourDigits.startsWith('53') ||
        firstFourDigits.startsWith('54') ||
        firstFourDigits.startsWith('55') ||
        firstFourDigits.startsWith('36') ||
        firstFourDigits.startsWith('38') ||
        firstFourDigits.startsWith('6011') ||
        firstFourDigits.startsWith('65') ||
        firstFourDigits.startsWith('35') ||
        firstFourDigits.startsWith('34') ||
        firstFourDigits.startsWith('37')) {
      if (cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '').length == 16) {
        return true;
      }
    }
    return false;
  }

  bool _validateCVV(String cvv) {
    if (cvv.length == 3) {
      return true;
    }
    return false;
  }

  bool _validateExpiryDate(String expiryDate) {
    List<String> parts = expiryDate.split('/');
    if (parts.length != 2) {
      return false;
    }

    int month = int.tryParse(parts[0]) ?? 0;
    int year = int.tryParse(parts[1]) ?? 0;

    if (month < 1 || month > 12) {
      return false;
    }

    DateTime now = DateTime.now();
    if (year < now.year % 100 ||
        year > now.year % 100 + 15 ||
        month < now.month) {
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }
}

class ExpiryDateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (oldValue.text != newText) {
      if (newText.length == 2 && newValue.selection.baseOffset == 2) {
        newText += '/';
      }
      if (newText.length > 5) {
        newText = newText.substring(0, 5);
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}
