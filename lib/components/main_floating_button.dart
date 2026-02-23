// components/main_floating_button.dart

import 'package:flutter/material.dart';

class MainFloatingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MainFloatingButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.add, color: Colors.black),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
