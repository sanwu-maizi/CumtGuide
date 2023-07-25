import 'package:flutter/material.dart';

class ButtonIndex extends StatelessWidget {

  final Color outerColor;
  final Color innerColor;
  final Widget child;

  const ButtonIndex({super.key,
    required this.outerColor,
    required this.innerColor,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth*0.7,
            height: constraints.maxWidth*0.7,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: outerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: innerColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: child,
            ),
          );
        }
    );
  }
}
