import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
    this.buttonColor,
    required this.onPressed,
  });

  final String buttonText;
  final Color? buttonColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
        child: Text(
          buttonText,
          style: TextStyle(color: buttonColor ?? Colors.black),
        ),
      ),
    );
  }
}
