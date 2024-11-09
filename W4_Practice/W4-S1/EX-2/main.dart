import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum Product {
  dart(
    title: 'Dart',
    description: 'Dart programming language',
    image: '../assets/images2/dart.png',
  ),
  flutter(
    title: 'Flutter',
    description: 'Flutter framework',
    image: '../assets/images2/flutter.png',
  ),
  firebase(
    title: 'Firebase',
    description: 'Firebase platform',
    image: '../assets/images2/firebase.png',
  );

  final String title;
  final String description;
  final String image;

  const Product({
    required this.title,
    required this.description,
    required this.image,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(p: Product.dart),
              Card(p: Product.firebase),
              Card(p: Product.flutter)
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key, required this.p,
  });

  final Product p;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: 500,
      height: 200,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              p.image, // Updated path for assets
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              p.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              p.title,
              textAlign: TextAlign.left, // Align text to the left
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

