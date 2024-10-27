import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: const Column(
        children: [
          CustomCard(label: "OOP", start: Colors.green, end: Colors.yellow),
          CustomCard(label: "DART", start: Colors.blue, end: Colors.red),
          CustomCard(label: "FLUTTER", start: Colors.white, end: Colors.black)
        ],
      ),
    ),
  ));
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key, required this.label, required this.start, required this.end,
  });

  final String label;
  final Color start;
  final Color end;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [start, end],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(label,
            style: const TextStyle(fontSize: 50, color: Colors.white)),
      ),
    );
  }
}

