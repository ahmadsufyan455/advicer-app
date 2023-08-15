import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  const ErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 50,
        ),
        const SizedBox(height: 16),
        Text(
          errorMessage,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
