import 'package:flutter/material.dart';

class ButtonIndex extends StatelessWidget {
  final Color outerColor;
  final Color innerColor;
  final Widget child;
  final VoidCallback onPressed; // Add this line
  final bool isCheck;

  const ButtonIndex({
    required this.outerColor,
    required this.innerColor,
    required this.child,
    required this.onPressed,
    required this.isCheck, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector( // Change InkWell to GestureDetector
        onTap: onPressed, // Assign the onPressed callback
        child: SizedBox(
            width: constraints.maxWidth * 0.9,
            height: constraints.maxWidth * 0.6,
            child: Stack(
              children: [
                if(isCheck)
                  Positioned(
                      left: 0,
                      top: constraints.maxWidth * 0.1,
                      child: Container(
                        height: constraints.maxWidth * 0.4,
                        width: constraints.maxWidth * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),    // 左上角
                            topRight: Radius.circular(constraints.maxWidth * 0.06),   // 右上角
                            bottomLeft: Radius.circular(0),  // 左下角
                            bottomRight: Radius.circular(constraints.maxWidth * 0.06), // 右下角
                          ),
                          color: Colors.blue, // 容器的背景颜色
                        ),
                      )),
                Positioned(
                  left: constraints.maxWidth * 0.15,
                  child: Container(
                      width: constraints.maxWidth * 0.6,
                      height: constraints.maxWidth * 0.6,
                      padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                      decoration: BoxDecoration(
                        color: outerColor,
                        borderRadius: BorderRadius.circular(constraints.maxWidth * 0.17),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: innerColor,
                          borderRadius: BorderRadius.circular(constraints.maxWidth * 0.15),
                        ),
                        child: child,
                      )
                  ),
                ),
              ],
            )
        ),
      );
    });
  }
}

