import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      padding: const EdgeInsets.all(50),
      margin: const EdgeInsets.all(40),
      color: Colors.blue.shade300,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.circular(15)
        ),
        child: const Center(
          child: Text("CADT STUDENTS",
          style: TextStyle(fontSize: 20, color: Colors.white),),
        ),
      ),
    ),
  ));
}
