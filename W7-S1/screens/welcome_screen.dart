 import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String quizTitle;
  final VoidCallback onStart;

  const WelcomeScreen({
    super.key,
    required this.onStart,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.flutter_dash,
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Text(
            quizTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: onStart,
            child: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
