import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HyperlinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const HyperlinkText({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontSize: 16,
        ),
        recognizer: TapGestureRecognizer()..onTap = onTap,
      ),
    );
  }
}