import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
 
  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );
  
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCurrency;
  String _convertedAmount = '';

  // Currency conversion rates (example rates)
  final Map<String, double> _conversionRates = {
    'Euro': 0.9513, 
    'Riel': 4038.45, 
    'Dong': 25406.50, 
  };

  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text);
    if (amount != null && _selectedCurrency != null) {
      final double rate = _conversionRates[_selectedCurrency]!;
      final double converted = amount * rate;
      setState(() {
        _convertedAmount =
            converted.toStringAsFixed(2); // Keep two decimal places
      });
    } else {
      setState(() {
        _convertedAmount = 'Invalid input or currency not selected';
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:"),
          const SizedBox(height: 10),

          TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                  prefix: const Text('\$ '),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter an amount in dollar',
                  hintStyle: const TextStyle(color: Colors.white)),
              style: const TextStyle(color: Colors.white)),

          const SizedBox(height: 30),
          const Text("Device: "),
          DropdownButton<String>(
            hint: const Text('Select Currency'),
            value: _selectedCurrency,
            items: _conversionRates.keys.map((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child:
                    Text(currency, style: const TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCurrency = newValue;
              });
            },
          ),
          const SizedBox(height: 30),
          const Text("Amount in selected device:"),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: textDecoration,
            child: Text(
              _convertedAmount.isEmpty
                  ? 'Please enter an amount and select a currency'
                  : _convertedAmount,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _convertCurrency,
            child: const Text('Convert'),
          ),
        ],
      )),
    );
  }
}
