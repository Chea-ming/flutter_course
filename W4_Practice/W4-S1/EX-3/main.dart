import 'package:flutter/material.dart';

// Enum for button types with colors
enum ButtonType { primary, secondary, disabled }

// Enum for icon position
enum IconPosition { left, right }

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconPosition iconPosition;
  final ButtonType buttonType;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    this.iconPosition = IconPosition.left,
    this.buttonType = ButtonType.primary,
  });

  Color _getButtonColor() {
    switch (buttonType) {
      case ButtonType.primary:
        return Colors.blue;
      case ButtonType.secondary:
        return Colors.green;
      case ButtonType.disabled:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: 450,
        child: ElevatedButton(
          onPressed: buttonType == ButtonType.disabled ? null : () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _getButtonColor(),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconPosition == IconPosition.left
                ? [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(label, style: const TextStyle(color: Colors.white)),
                  ]
                : [
                    Text(label, style: const TextStyle(color: Colors.white)),
                    const SizedBox(width: 8),
                    Icon(icon, color: Colors.white),
                  ],
          ),
        ),
      ),
    );
  }
}

// Example usage
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Buttons',
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom buttons')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                label: 'Submit',
                icon: Icons.check,
                buttonType: ButtonType.primary,
              ),
              CustomButton(
                label: 'Time',
                icon: Icons.access_time,
                buttonType: ButtonType.secondary,
              ),
              CustomButton(
                label: 'Account',
                icon: Icons.account_circle,
                buttonType: ButtonType.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
