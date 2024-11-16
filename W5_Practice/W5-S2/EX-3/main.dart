import 'package:flutter/material.dart';
import 'package:flutter_application_1/W5-S2/EX-3/screen/temperature.dart';
import 'package:flutter_application_1/W5-S2/EX-3/screen/welcome.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {

  bool _isTemperatureScreen = false;

  void _toggleScreen() {
    setState(() {
      _isTemperatureScreen = !_isTemperatureScreen;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff16C062),
                Color(0xff00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _isTemperatureScreen ? Temperature() : Welcome(toggleScreen: _toggleScreen),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}
