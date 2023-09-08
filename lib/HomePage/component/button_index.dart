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

class CustomShapeButton extends StatelessWidget {
  final Color outerColor;
  final Color innerColor;
  final Widget child;
  final VoidCallback onPressed;

  const CustomShapeButton({
    required this.outerColor,
    required this.innerColor,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: constraints.maxWidth * 0.6,
          height: constraints.maxWidth * 0.6,
          decoration: BoxDecoration(
            color: outerColor,
            borderRadius: BorderRadius.circular(8.0), // 圆角的半径，较小
          ),
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: innerColor,
              ),
              child: Center(child: child),
            ),
          ),
        ),
      );
    });
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cornerRadius = 8.0; // 圆角的半径，较小

    path.moveTo(cornerRadius, 0);
    path.lineTo(size.width - cornerRadius, 0);
    path.conicTo(size.width, 0, size.width, cornerRadius, 0.5); // 使用conicTo创建椭圆弧线
    path.lineTo(size.width, size.height - cornerRadius);
    path.conicTo(size.width, size.height, size.width - cornerRadius, size.height, 0.5);
    path.lineTo(cornerRadius, size.height);
    path.conicTo(0, size.height, 0, size.height - cornerRadius, 0.5);
    path.lineTo(0, cornerRadius);
    path.conicTo(0, 0, cornerRadius, 0, 0.5);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}