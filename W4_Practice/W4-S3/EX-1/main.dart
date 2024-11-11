import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Column of Buttons"),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Button(),
              SizedBox(height: 20), // Spacing between buttons
              Button(),
              SizedBox(height: 20),
              Button(),
              SizedBox(height: 20),
              Button(),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 100,
      child: ElevatedButton(
        onPressed: _toggleSelection,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isSelected ? Colors.blue.shade500 : Colors.blue.shade50,
        ),
        child: Center(
          child: Text(
            _isSelected ? "Selected" : "Not Selected",
            style: TextStyle(
              color: _isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
