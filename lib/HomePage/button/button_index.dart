import 'package:flutter/material.dart';

class ButtonIndex extends StatelessWidget {
  final Color outerColor;
  final Color innerColor;
  final Widget child;
  final VoidCallback onPressed; // Add this line

  const ButtonIndex({
    required this.outerColor,
    required this.innerColor,
    required this.child,
    required this.onPressed, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector( // Change InkWell to GestureDetector
        onTap: onPressed, // Assign the onPressed callback
        child: SizedBox(
          width: constraints.maxWidth * 0.6,
          height: constraints.maxWidth * 0.6,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: outerColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: innerColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: child,
            ),
          ),
        ),
      );
    });
  }
}

