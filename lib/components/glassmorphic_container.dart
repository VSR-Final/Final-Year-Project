import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomGlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius = 20;
  const CustomGlassmorphicContainer({super.key, this.width, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        width: width!,
        height: height!,
        borderRadius: borderRadius!,
        linearGradient: LinearGradient(
          colors: [
            const Color(0xFFffffff).withOpacity(0.1),
            const Color(0xFFFFFFFF).withOpacity(0.05),
          ],
        ),
        border: 2,
        blur: 20,
        borderGradient: LinearGradient(
          colors: [
            const Color(0xFFffffff).withOpacity(0.5),
            const Color(0xFFFFFFFF).withOpacity(0.5),
          ],
        ),
        child: Center(
            child: child),
    );
  }
}

