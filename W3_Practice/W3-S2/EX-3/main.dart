import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(30)),
            child: const Center(
              child: Text("OOP",
                  style: TextStyle(fontSize: 50, color: Colors.white)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(30)),
            child: const Center(
              child: Text("DART",
                  style: TextStyle(fontSize: 50, color: Colors.white)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 8, 22, 127)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30)),
            child: const Center(
              child: Text("FLUTTER",
                  style: TextStyle(fontSize: 50, color: Colors.white)),
            ),
          )
        ],
      ),
    ),
  ));
}
